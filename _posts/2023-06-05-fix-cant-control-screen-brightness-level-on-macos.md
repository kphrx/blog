---
category: tech
date: '2023-06-05 02:34:21 +0900'
---
# macOS で画面の明るさを変更できなくなったときの対処メモ

何らかの問題で <kbd>fn</kbd> + <kbd>F1</kbd>/<kbd>F2</kbd> や System Preferences.app のスライダーが効かなくなった時に雑に再起動する前に回復する手段がないか試した。

<!--more-->

macOS の画面の明るさはおそらく `/usr/libexec/corebrightnessd --launchd` のプロセスによって制御されている。変更できなくなった時にこのプロセスを殺して起動し直すことで状態が初期化されて回復する。
Activity Monitor.app で corebrightnessd を終了すると勝手に生き返る。

これだけの話だがもう少し掘り下げて、 `man hier` でディレクトリレイアウトを知ることができる。今回の corebrightnessd が置かれている `/usr/libexec` は

> system daemons & system utilities (executed by other programs)

と書かれていて隣の `/usr/sbin` は

> system daemons & system utilities (executed by users)

とされている

明るさと同様にキーボードショートカットがあるサウンドを制御してると思われる systemsoundserverd は `/usr/sbin` に置いてある。このディレクトリの違いは launchd によって起動されるかどうかの違い？

`man hier` から得られた情報でわかることは何かがうまく動いてないときは `/usr/{libexec,sbin}` 以下のデーモンバイナリを確認してそれらしい名前を見つけたらプロセスから探して殺すと上手くいくかもしれない。
