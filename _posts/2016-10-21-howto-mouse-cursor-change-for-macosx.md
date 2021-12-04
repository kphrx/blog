---
layout:     post
date:       2016-10-21 00:00:10 +0900
category:   macos

title: |
  Mousecape – Mac OS X でマウスカーソルを変更する方法
---

Mac OS X でマウスのカーソル(ポインター)を変更できるアプリの紹介

<!--more-->

{% include toc.md %}

## インストール方法
こちらのリンクから最新版の `Mousecape.zip` をダウンロードします(執筆時はPre-release版ですが0.0.5。Release版が出ればそちらを優先します)。リンク先でも"THIS IS NOT MOUSECAPE"と書いてある通りcursor flipは関係ありません  
[Releases · alexzielenski/Mousecape \| GitHub](https://github.com/alexzielenski/Mousecape/releases)

ダウンロードできたら展開。`Mousecape.app` をアプリケーションフォルダへ送ります  
そして起動。Macの起動時に動作するようにしなくてもいい方は気にしなくてもいいですがMousecapeが起動したら、左上のMousecapeのメニューから **[Install Helper Tool]** をクリックしてください。インストールが完了すると **[Uninstall Tool]** になります

## 使用方法
1. <kbd><kbd>&#8984; Cmd</kbd>+<kbd>N</kbd></kbd>もしくはメニューバーの **[File]** > **[New Cape]** で新しいcape(設定)を作成  
![New Cape 1]({{ '/images/macos/howto-mouse-cursor-change-for-macosx/new-cape-1.png' | relative_url }})  
![New Cape 2]({{ '/images/macos/howto-mouse-cursor-change-for-macosx/new-cape-2.png' | relative_url }})

2. 設定画面を開く
   - 新しく作られた `Unnamed` を右クリックしてEdit  
![Edit 1]({{ '/images/macos/howto-mouse-cursor-change-for-macosx/edit-1.png' | relative_url }})  
![Edit 2]({{ '/images/macos/howto-mouse-cursor-change-for-macosx/edit-2.png' | relative_url }})
   - 選択して<kbd><kbd>&#8984; Cmd</kbd>+<kbd>E</kbd></kbd>で設定画面を表示します

3. 表示されたらNameを変更しRetinaにチェックを入れます  
![Rename 1]({{ '/images/macos/howto-mouse-cursor-change-for-macosx/rename-1.png' | relative_url }})  
![Rename 2]({{ '/images/macos/howto-mouse-cursor-change-for-macosx/rename-2.png' | relative_url }})

4. 左下の+ボタンをクリックして `Unknown` を作り選択します  
![Add Type]({{ '/images/macos/howto-mouse-cursor-change-for-macosx/add-type.png' | relative_url }})

5. Typeを `Arrow` に変更。あらかじめ用意しておいたカーソルアイコンをx1にドラッグしてください  
![Change Type]({{ '/images/macos/howto-mouse-cursor-change-for-macosx/change-type.png' | relative_url }})

6. ウィンドウを閉じる時にSave  
![Save]({{ '/images/macos/howto-mouse-cursor-change-for-macosx/save.png' | relative_url }})

7. 自分が決めた名前のCapeを適用する
   - ダブルクリック、もしくは右クリックでApply
   - キーボードショートカットは選択して<kbd><kbd>&#8984; Cmd</kbd>+<kbd>&crarr; return</kbd></kbd>

設定を開いた時の最初のページのIdentifierはcapeファイルの名前になります。配布したりする場合は変更しておくといいでしょう

Typeを設定する画面のFrame、Frame Durationは、カーソルのアニメーションの設定になります。このツールではWindowsで一般的に使われている.aniファイルなどのカーソルアイコン用のファイルは使えないようですので一枚のPNGファイルを使ってアニメーションしてるように見せます。CSSスプライトをしているような感じ。例えば `32×32` のカーソルをアニメーションさせたいなら `32×64` `32×96` `32×128` といった具合に下に追加していき追加した数をFrameの数値に追加。Frame Durationで動く周期を設定できます。またそうした時にSizeをしっかり設定しておくのが大事です  
CSSスプライトのアニメーションに関してはこの記事がどういうものか分かりやすいのでどういう風にアニメーションさせてるかよくわからない人はどうぞ。こちらのページで横に動いてるものが縦に動いてるイメージです  
[CSSスプライトとstepsを使ってアニメーション画像を作ろう | Webクリエイターボックス](http://www.webcreatorbox.com/tech/css-sprite-steps/)

### aniファイルのpngへの変換
aniファイルを使う際にはPNGなどに変換する必要があります  
その変換に使うツールはどれでもいいですがMacに元から入ってるフレームワークでは.aniファイルは読めないのでAutomatorでは変換できません

執筆時ではアニメーションをスプライトで出力できるアプリを知らないのでここではアニメーションしない画像を出力するアプリとしてInkscapeを紹介しておきます  
[Mac OS X | Inkscape](https://inkscape.org/en/download/mac-os/)

.aniファイルなどをこのアプリで開き、<kbd><kbd>&#8963; Ctrl</kbd>+<kbd>&#8679; Shift</kbd>+<kbd>E</kbd></kbd>を押して適当な絶対パスでファイル名をつけて(Export as で指定してあげると楽です)、Exportをクリックするとファイルが出力されます。画像の解像度がおかしいときはImage Sizeを `32×32` 以上にしてやればいいかと思います

## Type 一覧
私がわかってる範囲ですので遭遇したことのないものはよくわかりません

またMacのデフォルトの状態は **[Capes]** > **[Dump Cursors…]** で出力できますがダウンロードできる状態でも置いておきます  
[Google Drive](https://drive.google.com/drive/folders/0B5KXUM3vvjTJZS0xd3ZBMjBoZzQ?resourcekey=0-DfCWRVAQsanJ_h78IsuwSw&usp=sharing)にアクセスしていただき *com.apple.mousecape.dump.default.cape* をダウンロードしてください

<dl>
  <dt>Alias</dt>
  <dd>何らかの代わり?</dd>
</dl>
<dl>
  <dt>Arrow</dt>
  <dd>普段のカーソル</dd>
</dl>
<dl>
  <dt>Busy</dt>
  <dd>作業中。デフォルトでは水色の回転カーソル</dd>
</dl>
<dl>
  <dt>Camera</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Camera 2</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Cell</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Cell XOR</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Closed</dt>
  <dd>何かを閉じる時に表示される?</dd>
</dl>
<dl>
  <dt>Copy</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Copy Drag</dt>
  <dd>ファイルなどを移動する時に表示される</dd>
</dl>
<dl>
  <dt>Counting Down</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Counting Up</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Counting Up/Down</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Crosshair</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Crosshair 2</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Ctx Arrow</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Ctx Menu</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Empty</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Forbidden</dt>
  <dd>ファイルなどを移動しようとする時に移動できないファイルの時などに表示される</dd>
</dl>
<dl>
  <dt>Help</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>IBeam</dt>
  <dd>文字列を選択する時や入力する場所にカーソルを動かした時に表示される</dd>
</dl>
<dl>
  <dt>IBeam H.</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>IBeamXOR</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Link</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Move</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Open</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Pointing</dt>
  <dd>リンクなどにホバーした時に表示される</dd>
</dl>
<dl>
  <dt>Poof</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Resize E</dt>
  <dd>Windowで表示されないリサイズ?</dd>
</dl>
<dl>
  <dt>Resize N</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Resize N-S</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Resize S</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Resize Square</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Resize W</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Resize W-E</dt>
  <dd>-</dd>
</dl>
<dl>
  <dt>Wait</dt>
  <dd>応答待ちなどで表示されるレインボーカーソル</dd>
</dl>
<dl>
  <dt>Window E</dt>
  <dd>おそらく最小サイズ時にウィンドウの右が拡大縮小できる時に表示される</dd>
</dl>
<dl>
  <dt>Window E-W</dt>
  <dd>ウィンドウの左右が拡大縮小できる時に表示される</dd>
</dl>
<dl>
  <dt>Window N</dt>
  <dd>おそらく最小サイズ時にウィンドウの上が拡大縮小できる時に表示される</dd>
</dl>
<dl>
  <dt>Window N-S</dt>
  <dd>ウィンドウの上下が拡大縮小できる時に表示される</dd>
</dl>
<dl>
  <dt>Window NE</dt>
  <dd>おそらく最小サイズ時にウィンドウの右上が斜めに拡大縮小できる時に表示される</dd>
</dl>
<dl>
  <dt>Window NE-SW</dt>
  <dd>ウィンドウの右上と左下が斜めに拡大縮小できる時に表示される</dd>
</dl>
<dl>
  <dt>Window NW</dt>
  <dd>おそらく最小サイズ時にウィンドウの左上が斜めに拡大縮小する時に表示される</dd>
</dl>
<dl>
  <dt>Window NW-SE</dt>
  <dd>ウィンドウの左上と右下が斜めに拡大縮小する時に表示される</dd>
</dl>
<dl>
  <dt>Window S</dt>
  <dd>おそらく最小サイズ時にウィンドウの下が拡大縮小できる時に表示される</dd>
</dl>
<dl>
  <dt>Window SE</dt>
  <dd>おそらく最小サイズ時にウィンドウの右下が斜めに拡大縮小する時に表示される</dd>
</dl>
<dl>
  <dt>Window SW</dt>
  <dd>おそらく最小サイズ時にウィンドウの左下が斜めに拡大縮小できる時に表示される</dd>
</dl>
<dl>
  <dt>Window W</dt>
  <dd>おそらく最小サイズ時にウィンドウの左が拡大縮小できる時に表示される</dd>
</dl>
<dl>
  <dt>Zoom In</dt>
  <dd>おそらくズーム機能で拡大時に表示されるもの</dd>
</dl>
<dl>
  <dt>Zoom Out</dt>
  <dd>おそらくズーム機能で縮小時に表示されるもの</dd>
</dl>

### Windows用aniとの関係
Windowsのaniでの種類との照合  
領域選択、手書き、バック作業、代替選択についてはどれかわかりませんでした

<dl>
  <dt>通常選択</dt>
  <dd>Arrow</dd>
</dl>
<dl>
  <dt>移動</dt>
  <dd>Arrow</dd>
</dl>
<dl>
  <dt>利用不可</dt>
  <dd>Forbidden</dd>
</dl>
<dl>
  <dt>ヘルプ</dt>
  <dd>Help</dd>
</dl>
<dl>
  <dt>テキスト選択</dt>
  <dd>IBeam</dd>
</dl>
<dl>
  <dt>リンク選択</dt>
  <dd>Pointing</dd>
</dl>
<dl>
  <dt>待ち状態</dt>
  <dd>Wait</dd>
</dl>
<dl>
  <dt>斜め拡大、縮小1</dt>
  <dd>Window NW-SE</dd>
</dl>
<dl>
  <dt>斜め拡大、縮小2</dt>
  <dd>Window NE-SW</dd>
</dl>
<dl>
  <dt>左右拡大、縮小</dt>
  <dd>window E-W</dd>
</dl>
<dl>
  <dt>上下拡大、縮小</dt>
  <dd>window N-S</dd>
</dl>

