---
category: tech
date: '2021-06-07 02:50:15 +0900'
redirect_from:
  - /blog/oracle-cloud-always-free-ubuntu-setup
hasCodeSnippet: true
---

# Oracle Cloud Always Free の Canonical Ubuntu 20.04 (Minimal) のセットアップ

Oracle Cloud の Always Free で APT と Docker + nftables の設定をする

<!--more-->

Oracle Cloud の Canonical Ubuntu 20.04 (Minimal) は何も設定しないと、せっかくの minimized で `apt install` の時に Recommends にされてるパッケージまでまとめて入れてしまうので自動更新とかも合わせてちゃんと設定する


## `APT::Install-*` と Docker と nftables をまとめて設定
GitHub Gist でスクリプトを公開してあるので `curl | bash` してしまう  
<https://gist.github.com/kphrx/ae6f2dfd0e12ba70a8f6c9d338272ba7>
```console
$ curl -fsSL https://gist.github.com/kphrx/ae6f2dfd0e12ba70a8f6c9d338272ba7/raw/ubuntu_minimal_docker_nftables_install.bash | bash
```

やってることは順番に
1. Recommends と Suggests を明示的にインストールしないようにする
2. Docker の Ubuntu 用 Repository の GPG key を取得
3. APT のソースリストに Docker Repository を追加
4. APT の更新
5. `docker-ce` (と依存関係の `docker-ce-cli`, `containerd.io`) と `nftables` のインストール
6. Docker が利用する iptables を iptables-nft にして nftables を使うようにする
7. これを実行してるユーザーを `docker` group に追加して `sudo` 無しで `docker` を使えるようにする

## APT の自動更新
デフォルトで `unattended-upgrades` が入ってるので `/etc/apt/apt.conf.d/50unattended-upgrades` を編集する

Ubuntu Minimal には `emacs` も `nano` も `vim` や `vi` ですら入ってないので `sed` でコメントを外して値を変える

### `apt autoremove` と 再起動
`apt autoremove` に相当する `Unattended-Upgrade::Remove-Unused-Dependencies` と 再起動が必要な時に勝手に再起動させる `Unattended-Upgrade::Automatic-Reboot` を `true` にする
```console
$ sudo sed -i'' -e's#//\(Unattended-Upgrade::\(Remove-Unused-Dependencies\|Automatic-Reboot\) "\)false\(";\)#\1true\3#' /etc/apt/apt.conf.d/50unattended-upgrades
```

`Unattended-Upgrade::Automatic-Reboot "true"` にした時の再起動の時間を 02:00 UTC から 04:00 JST にする
- 19:00 UTC で日本時間4時にする
```console
$ sudo sed -i'' -e's#//\(Unattended-Upgrade::Automatic-Reboot-Time "\)02\(:00";\)#\119\2#' /etc/apt/apt.conf.d/50unattended-upgrades
```
- timezone を `Asia/Tokyo` にして 04:00 JST を設定する
```console
$ sudo timedatectl set-timezone Asia/Tokyo
$ sudo sed -i'' -e's#//\(Unattended-Upgrade::Automatic-Reboot-Time "\)02\(:00";\)#\104\2#' /etc/apt/apt.conf.d/50unattended-upgrades
```

### メール通知
自動更新の通知をメールで受け取るには `Unattended-Upgrade::Mail` にメールアドレスを入れる
```console
$ sudo sed -i'' -e's#//\(Unattended-Upgrade::Mail "\)\(";\)#\1user@mail.example.com\2#' /etc/apt/apt.conf.d/50unattended-upgrades
```

メールをエラーが起きた時だけにする場合は `Unattended-Upgrade::MailReport` を `only-on-error` にする
```console
$ sudo sed -i'' -e's#//\(Unattended-Upgrade::MailReport "\)on-change\(";\)#\1only-on-error\2#' /etc/apt/apt.conf.d/50unattended-upgrades
```

### 差分
```diff
 // 更新通知メール
-//Unattended-Upgrade::Mail "";
+Unattended-Upgrade::Mail "user@mail.example.com";
 
-//Unattended-Upgrade::MailReport "on-change";
+Unattended-Upgrade::MailReport "only-on-error";
 
 // apt-get autoremove
-//Unattended-Upgrade::Remove-Unused-Dependencies "false";
+Unattended-Upgrade::Remove-Unused-Dependencies "true";
 
 // 自動再起動
-//Unattended-Upgrade::Automatic-Reboot "false";
+Unattended-Upgrade::Automatic-Reboot "true";
 
-//Unattended-Upgrade::Automatic-Reboot-Time "02:00";
+Unattended-Upgrade::Automatic-Reboot-Time "04:00";
```

## nftables
~~Oracle Cloud でのファイアウォールの設定まだわかってないので、~~ひとまず nftables で IPv4 と IPv6 両方使えるようにして ping と ssh http/https を許可して Docker のループバックができるような感じの設定を `/etc/nftables.conf` に書き込む

~~Oracle Cloud の日本リージョンではまだ IPv6 の Public IP を貰えないので[^1] IPv6 をここで使えるようにする意味は基本的にない~~英語のページで全てのリージョンでIPv6サポートしてるよって書いてあった[^2]。日本語も更新してくれ……

Oracle Cloud では cloud-init サービス が `dhclient` を呼ぶことで VNIC で割り当てた IPv6 がネットワークインターフェースに追加されるので dhcpv6-client(546/udp) を開けておく必要がある

~~Oracle Cloud VCN で相互に通信する必要がある場合は `ip daddr 10.0.0.0/24 accept` などで Private IP は素通りさせるように設定する必要があるかもしれない？~~

```nft?filename=/etc/nftables.conf
#!/usr/sbin/nft -f

flush ruleset

table inet filter {
	chain input {
		type filter hook input priority 0; policy drop;
		ct state related,established accept
		iif lo accept
		ct state invalid drop
		icmpv6 type { nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert } accept
		icmpv6 type echo-request accept
		icmp type echo-request accept
		tcp flags & (fin | syn | rst | ack) == syn ct state new jump TCP
		reject with tcp reset
		ct state new jump UDP
	}
	chain forward {
		type filter hook forward priority 0; policy drop;
		ct state related,established accept
		iif "lo" accept
		ct state invalid drop
		mark 1 accept
	}
	chain output {
		type filter hook output priority 0; policy accept;
	}
	chain TCP {
		tcp dport ssh accept
		tcp dport http accept
		tcp dport https accept
	}
	chain UDP {
		udp dport domain accept
		udp dport https accept
		udp dport dhcpv6-client accept
		udp dport dhcpv6-server accept
	}
}

table ip filter {
	chain DOCKER-USER {
		mark set 1
	}
}
```

`iptables-restore` を呼んでいる `netfilter-persistent.service` を無効にして `nftables.service` を有効化する

```console
$ sudo systemctl disable netfilter-persistent
$ sudo systemctl enable nftables
$ sudo reboot
```

## 注釈
[^1]:
    IPv6アドレス指定は、現在、米国Government Cloudでのみサポートされています。すべての米国Government Cloudのお客様を参照してください。  
    <https://docs.oracle.com/ja-jp/iaas/Content/Network/Concepts/ipv6.htm>

[^2]:
    IPv6 addressing is supported for all commercial and government regions.  
    <https://docs.oracle.com/en-us/iaas/Content/Network/Concepts/ipv6.htm>
