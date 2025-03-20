---
category: tech
date: '2020-02-07 21:21:13 +0900'
redirect_from:
  - /blog/docker-compose-nginx-proxy
hasCodeSnippet: true
---

# docker-composeを使ってnginxのリバースプロキシを設置する

nginxのdocker imageをSSL証明書を自動更新しながら使う。

<!--more-->

[サーバーを引っ越した話](https://blog.kpherox.dev/blog/change-vps-server.html)で最初に使ったイメージが悪かったので置き換えた


## 最初のDocker image
サーバー移転した時には[Neilpang/nginx-proxy][]をforkした[kPherox/autocert-nginx-proxy][]を使ってた。fork元では[jwilder/nginx-proxy][]のfork(Neilpang/nginx-proxy-base)でnginxバージョンをlatestにする変更があったのだけれどimageを定期的に作り直してなく、むしろメンテされてるfork元の方が新しいnginxを利用するようになっていたので[jwilder/nginx-proxy][]を直接使うような変更を加えていた

しかし証明書の期限まで1ヶ月になった今月、問題が発生した  
このimageで利用している[acme.sh][acmesh-official/acme.sh]は`/etc/nginx/conf.d`にある設定のバックアップを取って`location ^~ /.well-known/acme-challenge/<filename>`の設定を追加するようになっているため`conf.d`ではなく`vhost.d`をserverディレクティブで読み込んでいるこのimageではそれが追加されたところで全く意味がない

結局Invalid responseで証明書の更新がうまくいかないので別の方法を探すかどうにかimageを修正しなければいけない必要が出てきた

## 一度docker-compose v3で使うことを諦めてた方法
docker-composeは`docker --volumes-from`と同様のプロパティをv3になって廃止した。そのため、[JrCs/docker-letsencrypt-nginx-proxy-companion][]のような`--volumes-from`に依存する設計だと素直に使えないしdocker-composeの問題ということになって閉じられてるIssueまであった[^1]

ただこちらは継続的にメンテされており先に使っていたものと違って正しく動くことが期待できるため、どうにか使う方法はないかとIssueを探すことにした

## docker-compose v3で廃止された`volumes_from`に相当する設定
とにかくvolumes_fromと同じことをしなくてはいけない。Docker公式のドキュメントにはnamed volumesを設定するといいとある[^2]ので適当にvolumesを設定してみることにした

```yaml?filename=compose.yml
version: '3.5'
services:

  nginx-proxy:
    image: jwilder/nginx-proxy:alpine
    network_mode: host
    ports:
      - "443:443"
      - "80:80"
    environment:
      - ENABLE_IPV6=true
      - VIRTUAL_HOST=kpherox.dev,www.kpherox.dev
      - LETSENCRYPT_HOST=kpherox.dev,www.kpherox.dev
    volumes:
      - doc_root:/var/www
      - html:/usr/share/nginx/html
      - dhparam:/etc/nginx/dhparam
      - conf:/etc/nginx/conf.d
      - vhost:/etc/nginx/vhost.d
      - certs:/etc/nginx/certs:ro
      - /var/run/docker.sock:/tmp/docker.sock:ro

  autocert:
    image: jrcs/letsencrypt-nginx-proxy-companion:latest
    environment:
      - DEFAULT_EMAIL=admin@mail.kr-kp.com
      - VIRTUAL_HOST=kpherox.dev,www.kpherox.dev
    volumes:
      - html:/usr/share/nginx/html
      - certs:/etc/nginx/certs:rw
      - vhost:/etc/nginx/vhost.d
      - /var/run/docker.sock:/var/run/docker.sock:ro

volumes:
  doc_root:
    driver_opts:
      type: none
      o: bind
      device: /path/to/document_root
  html:
    driver_opts:
      type: none
      o: bind
      device: /path/to/html
  conf:
    driver_opts:
      type: none
      o: bind
      device: /path/to/conf.d
  vhost:
    driver_opts:
      type: none
      o: bind
      device: /path/to/vhost.d
  dhparam:
  certs:
```

これでうまくいくかと思いきやautocertサービスがnginx-proxyを見つけられないようで解決しなかった。もう一度Issueを漁ると[Compose V3 Compatibility - fix volume_from](https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion/issues/159)で "This works for me" とリンクが貼られていた[^3]

どうやら`depends_on`でnginx-proxy serviceを設定するといいらしい  
<https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion/issues/102#issuecomment-463573796>

なので最終的に以下の変更で動くようになった

```diff
--- old/compose.yml
+++ new/compose.yml
@@ -3,10 +3,8 @@
 
   nginx-proxy:
     image: jwilder/nginx-proxy:alpine
+    restart: always
     network_mode: host
-    ports:
-      - "443:443"
-      - "80:80"
     environment:
       - ENABLE_IPV6=true
       - VIRTUAL_HOST=kpherox.dev,www.kpherox.dev
@@ -15,17 +13,22 @@
       - doc_root:/var/www
       - html:/usr/share/nginx/html
       - dhparam:/etc/nginx/dhparam
-      - conf:/etc/nginx/conf.d
       - vhost:/etc/nginx/vhost.d
       - certs:/etc/nginx/certs:ro
       - /var/run/docker.sock:/tmp/docker.sock:ro
+    labels:
+      - "com.github.jrcs.letsencrypt_nginx_proxy_companion.nginx_proxy"
 
   autocert:
     image: jrcs/letsencrypt-nginx-proxy-companion:latest
+    restart: always
+    depends_on:
+      - "nginx-proxy"
     environment:
       - DEFAULT_EMAIL=admin@mail.kr-kp.com
       - VIRTUAL_HOST=kpherox.dev,www.kpherox.dev
     volumes:
+      - doc_root:/var/www
       - html:/usr/share/nginx/html
       - certs:/etc/nginx/certs:rw
       - vhost:/etc/nginx/vhost.d
@@ -42,11 +45,6 @@
       type: none
       o: bind
       device: /path/to/html
-  conf:
-    driver_opts:
-      type: none
-      o: bind
-      device: /path/to/conf.d
   vhost:
     driver_opts:
       type: none
```

実際にはpleromaを別のdocker-composeで動かしてるので`nginx-proxy`を`network_mode: host`にして`conf.d`も`nginx-proxy`のvolumesに追加してupstreamにpleromaを追加している。pleromaを更新する時にdockerのscaleを使ってコンテナを切り替えるようにしてるので複数のportへプロキシする必要があるためこうしている


## 注釈
[^1]: <https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion/issues/597#issuecomment-551144800>
[^2]: <https://docs.docker.com/compose/compose-file/#volume-configuration-reference>
[^3]: <https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion/issues/159#issuecomment-484383687>


[Neilpang/nginx-proxy]: https://github.com/Neilpang/nginx-proxy
[kPherox/autocert-nginx-proxy]: https://github.com/kPherox/autocert-nginx-proxy
[jwilder/nginx-proxy]: https://github.com/jwilder/nginx-proxy
[acmesh-official/acme.sh]: https://github.com/acmesh-official/acme.sh
[JrCs/docker-letsencrypt-nginx-proxy-companion]: https://github.com/JrCs/docker-letsencrypt-nginx-proxy-companion
