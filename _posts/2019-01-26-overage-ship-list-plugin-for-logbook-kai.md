---
layout:     post
date:       2019-01-26 06:04:26 +0900
category:   kancolle
redirect_from:
  - /games/kancolle/overage-ship-list-plugin-for-logbook-kai

title: |
  航海日誌（logbook-kai）で改造可能な艦娘のリストを表示するプラグイン
---

本当は19冬イベ期間中に作ってE2Qやりながら見たかったやつ  
本体の経験値計算機の改装レベル不足の艦娘とお風呂に入りたい艦娘のTableViewを参考にしてサクッと作成

<!--more-->

* Table Of Contents
{:toc}

## 導入
`overageship.jar` をlogbook-kaiのあるディレクトリ内の `plugins` ディレクトリに入れて再起動してください

ダウンロードは下記URL  
[Release latest · kPherox/logbook-overage-ship-list-plugin \| GitHub](https://github.com/kPherox/logbook-overage-ship-list-plugin/releases/latest)

## 使い方
プラグインを導入したらコマンドのメニューの下部に改造可能な艦娘って項目が追加されてるのでクリックしてください  
すると以下のようなウィンドウが表示されます  
![window]({{ '/images/kancolle/overage-ship-list-plugin-for-logbook-kai/window.png' | relative_url }})

執筆時点でリリースしている1.0.0は自動更新されないので開き直す必要あります。次のバージョンで実装する予定  
あとはコンバート改装を非表示にするオプションとか改造可能Lvになったら通知するような機能は実装したい（願望）
