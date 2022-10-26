---
category: macos
date: '2017-02-02 00:00:25 +0900'
---

# Mac用のニコ生TSダウンローダー

ニコ生のタイムシフトをダウンロードできるMacアプリを~~開発中です~~モチベ低下につき停止中

<!--more-->

Mac向けにはNicoTimeShiftというものがすでにありますが、El Capitanでうまく動かず…  
オープンソースなのでどうなってるのか確かめたところ、これはSafariなどのブラウザのCookieを使ってるのですが
- SafariのCookieはPlistを参照するようになっているがEl CapitanではSQLite形式に成っているのでそもそも使えない
- Google ChromeなどのCookieもうまく使えてないのか一向に進まない
などの理由で自作しようと思いました

~~完成したらMITライセンスで配布予定~~とりあえず公開しました（プレリリース版です）  
[Releases · kPherox/NicoDownloader \| GitHub](https://github.com/kPherox/NicoDownloader/releases)

プレリリース版の0.0.1には以下のrtmpdumpバイナリを同梱しています  
[taonico/rtmpdump-nico-live \| GitHub](https://github.com/taonico/rtmpdump-nico-live)

将来的にはlibrtmp.dylibを同梱しようと考えていますが、私がプレミアム会員を解除しまして開発へのモチベがかなり低いです  
まぁ正式リリース版が出るときにはちゃんとそうなってると思う。~~出るのか？~~
