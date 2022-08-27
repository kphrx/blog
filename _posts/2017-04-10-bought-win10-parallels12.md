---
date:       2017-04-10 00:00:14 +0900
category:   blog
---

# Windows10とParallels12買った話

今回はWindows 10 Professional リテール版とParallels Desktop 12 for Macを買った話です。若干人柱的な報告も

<!--more-->

{% include toc.md %}

## Windows 10 Professional リテール版について
C#でクロスプラットフォーム開発したいなぁとか思ってたのでWindowsが欲しかった  
というわけで以前から購入機会があれば手に入れようと思ってたのですがTwitterのタイムラインで偶然psngames.orgとやらを発見しまして…こちらのサイトでは$15.74とかいうふざけた廉価で売ってたので購入しました  
実際に使えるかどうかや購入の仕方は後述

## Parallels Desktop 12 for Macについて
とりあえずWindows買ったもののどうやって使うか考えていなかった  
じゃあBootCampしてみるかってことでBoot Camp Assistant開いて色々やってたんですけどエラー吐かれちゃいまして  
ググったら「PRAMのリセット」とか「Recovery OSでFirst Aidしろ」とか「BootCampでパーティション分けせずに自分でパーティション分ける」とか色々ありとりあえず試してみたものの `exit code 8` でダメ  
これの解決策はOS X(macOS)の再インストールしかないってGoogle検索結果にめんどくさいしなぁ。。。と

そこで「そうだ、仮想環境！」なんて思い、Parallelsのコヒーレンスモード使ってみたいと思ったのでとりあえずAmazonでUSB版をポチりました。~~20%オフだったしまぁ損はしてないだろう~~  
そのあとに気がついたダウンロード版の存在……~~USBかっこいいし（震え声）~~

届く前にそれをインストールしてPro版をトライアルで使ってみました  
Proである恩恵は今のところあまり感じてませんが（VSのプラグインてなんだ？）VirtualBoxよりは快適に使えます  
コヒーレンスモードもまぁ悪くない。もっぱらフルスクリーンで使ってますが

ただ8GBしかメモリを積んでない私のiMacじゃ重くてね……  
いずれ8GB x2に換装するか新しいMacに買い換えるかと言ったところ（予定は未定）

それからParallels DesktopについてきたParallels Toolboxがまぁ便利  
ショートカット忘れた時とかMacをすぐにロックしたい時とかタイマーなんかがすぐに設定できるのがとてもいい  
~~それと4ヶ月分のParallels Accessのライセンスもついてきましたがこれは使うことはないかなぁ…他に使う場所もないしデスクトップ共有したい相手もいないし。。。  
というかChrome Remote Desktopとかでも十分代用可能っぽい感じが~~Androidでリモートデスクトップ使うと快適さが段違いでした…Chrome Remote Desktopなんて、かくつくしストレス溜まりますわ……

## psngames.orgで買ったWindows 10 Professional
結論から先に言うと、使えます  
Parallelsに打ち込んでインストールすると割とあっけなくデスクトップが表示されました。今まで評価版とかしかインストールしたことがないから普通のWin10の背景でちょっと感動してしまった…  
まぁそんな冗談は置いといて購入方法ですが
1. OEM Versionのチェックを外してRetail Versionにチェックをつける
2. ADD TO CARTをクリック
3. Checkoutの画面でEmail AddressとFirst Nameに適当なアドレスと名前を入れる。本名でなくてもok
4. I understand the above conditions（訳：私は以上の内容に同意します）にチェックを入れる
5. すると支払い方法の選択画面になる。さすがにクレジットカード情報を入力するのは嫌なのでPayPalを選ぶ
6. PayPalの画面になるのでログイン。同意して支払うをクリック
7. これで購入完了。プロダクトキーが表示されるのでメモする。メールでも来るのでそちらでもok
と言った流れになります

途中G2Aのページが挟まれますが特に問題はないはずです。こちらのサイト、Office 2016 Professionalも安く売ってるのでかなり良いのではと思います。それでもfor Macは高いですが…  
リンクはこちら: <https://psngames.org/downloads/microsoft-windows-10-professional/>

## おわり
これで私もWindowsアプリが作れるようになったなって思います。まぁParallels重たくてまともに開発しようとも思えないのですが…  
VMWareの方が良かったのかなぁ…？VMWare Fusion 8.5がParallelsユーザーだと40%割引されるとのことでまぁ買ってもいいかもしれない？
