---
category: Technology
tags: NGINX
date: '2019-03-08 20:17:37 +0900'
redirect_from:
  - /tech/can-use-variable-on-ssl-certificate-but-should-not-use-variable
  - /blog/can-use-variable-on-ssl-certificate-but-should-not-use-variable
hasCodeSnippet: true
---

# Nginxのssl_certificateでの変数は使い物にならない

Nginx 1.15.9から `ssl_certificate` で変数を利用することが可能になったけど利用を諦めた理由です

<!--more-->

そんな大して書くこともないのでチラシの裏みたいな自分のブログで書いておく


## 使おうと思ったきっかけ
仮想ホストにドメイン複数みたいなことしてると

- ワイルドカード証明書使っていてもそれぞれのドメインの分だけ書くのもめんどくさい
- `$host` とかの変数で書く量減らせないかな

みたいなこと思いv1.15.9へアップデートした（このバージョンから変数をサポートしてる）


## 実際に使う
自分で設定した変数を使えないのでLet's Encryptのpemファイルへのsymlinkを使って、ドメイン部分を `$host` 変数を利用してみたが、アクセスされるたびに証明書とか秘密鍵とか読み込んでるっぽくてエラーを吐いてた  
→ `systemd` での起動時はともかく動いている時はrootユーザーではないので `/etc/letsencrypt/{archive,live}` のディレクトリのパーミッションを `700 (drwx------)` から `755 (drwxr-xr-x)` にするとかが必要だった

ちなみにこんな感じ

```nginx?filename=/etc/nginx/conf.d/example.com.conf
server {
    listen          433 ssl http2;
    server_name     example.com www.example.com;

    include         conf.d/ssl_certificate.conf;

    ...
}
```

```nginx?filename=/etc/nginx/conf.d/ssl_certificate.conf
ssl_certificate         /etc/letsencrypt/live/$host/fullchain.pem;
ssl_certificate_key     /etc/letsencrypt/live/$host/privkey.pem;

# ssl_trusted_certificate /etc/letsencrypt/live/example.com/chain.pem;
```

`ssl_trusted_certificate` には ***変数が使えない*** 。しかし同じ認証局なら同一のものなので複数の認証局を使っているのでなければ記述を共通化できる


## 弊害
変更してしばらくの間はおそらく問題はなかった。しかし「mastodonを動かしてNginxで繋いでみる」みたいなことをした時にNginxが落ちるようになってしまった（そもそもサーバーのマシンスペックもギリギリだが）  
→アクセスされるたびに読み込んでいる証明書がネックになってるのでは  
→元に戻す  
→ちゃんと動く  
→\\(^o^)/


## オチ
結局元のように変数を使わずに読み込むように。かなりの高性能なサーバーでもI/Oコストのボトルネックが無視できなくなるだろう問題っぽいので使うのは見送り

使うなら

- 自分で設定した変数の利用
- 起動時に想定できる名前であらかじめ読み込むなどしてアクセスのたびに I/O が発生しない

って感じにNginxの更新が入らないことにはみたいな感じだった


## さらにオチ
この記事の数日前の投稿があったし（<https://nozomi1773.hatenablog.com/entry/2019/03/04/211928>）

ドキュメントにも
> Note that using variables implies that a certificate will be loaded for each SSL handshake, and this may have a negative impact on performance.
>
> <http://nginx.org/en/docs/http/ngx_http_ssl_module.html#ssl_certificate>

と書かれているのを見逃していた。NginxにSwiftの `switch` とかみたいな網羅性を期待するのはおかしい気もしてきた。まぁ使い物にならないって結論は変わらない
