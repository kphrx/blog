---
category: tech
date: '2022-10-27 00:03:47 +0900'
---
# フォント『LINE Seed Sans』をHomebrew Caskで管理する

日本語版のLINE Seed JPが公開されたが`homebrew/cask-fonts`にはLINE Seed ENすらなかったのでEN/JP/KR/THをそれぞれインストールできるようにCaskを作った

<!--more-->

## インストール方法

Homebrew Caskからフォントをインストールすると`~/Library/Fonts`へ保存される

とりあえず自分のtap(`kphrx/personal`)で公開中

Caskのバージョンは日本語以外のバージョンは`:latest`。日本語版だけディレクトリ名に日付入ってる都合でバージョンは`20221014`

### 日本語版 `font-line-seed-jp`

```console
$ brew install kphrx/personal/font-line-seed-jp
```

#### 日本語版フォントファイル

App, Web, Desktopの3種類入っていて、AppとDesktopはそれぞれTTFとOTF、WebはWOFFとWOFF2、EOTが用意されている

細い順に Thin(`Th`), Regular(`Rg`), Bold(`Bd`), ExtraBold(`Eb`) がある

- LINESeedJP_A_TTF_Th.ttf
- LINESeedJP_A_TTF_Rg.ttf
- LINESeedJP_A_TTF_Bd.ttf
- LINESeedJP_A_TTF_Eb.ttf
- LINESeedJP_A_OTF_Th.otf
- LINESeedJP_A_OTF_Rg.otf
- LINESeedJP_A_OTF_Bd.otf
- LINESeedJP_A_OTF_Eb.otf
- LINESeedJP_OTF_Th.woff
- LINESeedJP_OTF_Rg.woff
- LINESeedJP_OTF_Bd.woff
- LINESeedJP_OTF_Eb.woff
- LINESeedJP_OTF_Th.woff2
- LINESeedJP_OTF_Rg.woff2
- LINESeedJP_OTF_Bd.woff2
- LINESeedJP_OTF_Eb.woff2
- LINESeedJP_TTF_Th.eot
- LINESeedJP_TTF_Rg.eot
- LINESeedJP_TTF_Bd.eot
- LINESeedJP_TTF_Eb.eot
- LINESeedJP_TTF_Th.ttf
- LINESeedJP_TTF_Rg.ttf
- LINESeedJP_TTF_Bd.ttf
- LINESeedJP_TTF_Eb.ttf
- LINESeedJP_OTF_Th.otf
- LINESeedJP_OTF_Rg.otf
- LINESeedJP_OTF_Bd.otf
- LINESeedJP_OTF_Eb.otf


### 英語版 `font-line-seed-en`

```console
$ brew install kphrx/personal/font-line-seed-en
```

#### 英語版フォントファイル

App, Web, Desktopの3種類入っていて、AppとDesktopはそれぞれTTFとOTF、WebはWOFFとWOFF2、EOTが用意されている

細い順に Thin(`Th`), Regular(`Rg`), Bold(`Bd`), ExtraBold(`XBd`), Heavy(`He`) がある

- LINESeedSans_A_Th.ttf
- LINESeedSans_A_Rg.ttf
- LINESeedSans_A_Bd.ttf
- LINESeedSans_A_XBd.ttf
- LINESeedSans_A_He.ttf
- LINESeedSans_A_Th.otf
- LINESeedSans_A_Rg.otf
- LINESeedSans_A_Bd.otf
- LINESeedSans_A_XBd.otf
- LINESeedSans_A_He.otf
- LINESeedSans_W_Th.woff
- LINESeedSans_W_Rg.woff
- LINESeedSans_W_Bd.woff
- LINESeedSans_W_XBd.woff
- LINESeedSans_W_He.woff
- LINESeedSans_W_Th.woff2
- LINESeedSans_W_Rg.woff2
- LINESeedSans_W_Bd.woff2
- LINESeedSans_W_XBd.woff2
- LINESeedSans_W_He.woff2
- LINESeedSans_W_Th.eot
- LINESeedSans_W_Rg.eot
- LINESeedSans_W_Bd.eot
- LINESeedSans_W_XBd.eot
- LINESeedSans_W_He.eot
- LINESeedSans_Th.ttf
- LINESeedSans_Rg.ttf
- LINESeedSans_Bd.ttf
- LINESeedSans_XBd.ttf
- LINESeedSans_He.ttf
- LINESeedSans_Th.otf
- LINESeedSans_Rg.otf
- LINESeedSans_Bd.otf
- LINESeedSans_XBd.otf
- LINESeedSans_He.otf


### 韓国語版 `font-line-seed-kr`

```console
$ brew install kphrx/personal/font-line-seed-kr
```

#### 韓国語版フォントファイル

TTFとOTF、WebfontはWOFF/WOFF2/EOTが用意されている

細い順に Thin(`Th`), Regular(`Rg`), Bold(`Bd`) がある

- LINESeedSansKR-Th.ttf
- LINESeedSansKR-Rg.ttf
- LINESeedSansKR-Bd.ttf
- LINESeedSansKR-Th.otf
- LINESeedSansKR-Rg.otf
- LINESeedSansKR-Bd.otf
- LINESeedSansKR-Th.woff
- LINESeedSansKR-Rg.woff
- LINESeedSansKR-Bd.woff
- LINESeedSansKR-Th.woff2
- LINESeedSansKR-Rg.woff2
- LINESeedSansKR-Bd.woff2
- LINESeedSansKR-Th.eot
- LINESeedSansKR-Rg.eot
- LINESeedSansKR-Bd.eot


### タイ語版 `font-line-seed-th`

```console
$ brew install kphrx/personal/font-line-seed-th
```

#### タイ語版フォントファイル

App, Web, Desktopの3種類入っていて、AppとDesktopはそれぞれTTFとOTF、WebはWOFFとWOFF2、EOTが用意されている

細い順に Thin(`Th`), Regular(`Rg`), Bold(`Bd`), ExtraBold(`XBd`), Heavy(`He`) がある

- LINESeedSansTH_A_Th.ttf
- LINESeedSansTH_A_Rg.ttf
- LINESeedSansTH_A_Bd.ttf
- LINESeedSansTH_A_XBd.ttf
- LINESeedSansTH_A_He.ttf
- LINESeedSansTH_A_Th.otf
- LINESeedSansTH_A_Rg.otf
- LINESeedSansTH_A_Bd.otf
- LINESeedSansTH_A_XBd.otf
- LINESeedSansTH_A_He.otf
- LINESeedSansTH_W_Th.woff
- LINESeedSansTH_W_Rg.woff
- LINESeedSansTH_W_Bd.woff
- LINESeedSansTH_W_XBd.woff
- LINESeedSansTH_W_He.woff
- LINESeedSansTH_W_Th.woff2
- LINESeedSansTH_W_Rg.woff2
- LINESeedSansTH_W_Bd.woff2
- LINESeedSansTH_W_XBd.woff2
- LINESeedSansTH_W_He.woff2
- LINESeedSansTH_W_Th.eot
- LINESeedSansTH_W_Rg.eot
- LINESeedSansTH_W_Bd.eot
- LINESeedSansTH_W_XBd.eot
- LINESeedSansTH_W_He.eot
- LINESeedSansTH_Th.ttf
- LINESeedSansTH_Rg.ttf
- LINESeedSansTH_Bd.ttf
- LINESeedSansTH_XBd.ttf
- LINESeedSansTH_He.ttf
- LINESeedSansTH_Th.otf
- LINESeedSansTH_Rg.otf
- LINESeedSansTH_Bd.otf
- LINESeedSansTH_XBd.otf
- LINESeedSansTH_He.otf


## アーカイブファイルの構造

配信されてるアーカイブの構造やファイル名は`brew info`でわかるがバラバラ

### 日本語版

ファイル名になぜかTTF/OTFが書かれてる。拡張子 #とは

日本語版だけ一番上のディレクトリ名に日付が入ってる。なんで？？？？？

- LINE_Seed_JP_20221014/
  - App/
    - TTF/
      - LINESeedJP_A_TTF_Th.ttf
      - LINESeedJP_A_TTF_Rg.ttf
      - LINESeedJP_A_TTF_Bd.ttf
      - LINESeedJP_A_TTF_Eb.ttf
    - OTF/
      - LINESeedJP_A_OTF_Th.otf
      - LINESeedJP_A_OTF_Rg.otf
      - LINESeedJP_A_OTF_Bd.otf
      - LINESeedJP_A_OTF_Eb.otf
  - Web/
    - WOFF/
      - LINESeedJP_OTF_Th.woff
      - LINESeedJP_OTF_Rg.woff
      - LINESeedJP_OTF_Bd.woff
      - LINESeedJP_OTF_Eb.woff
    - WOFF2/
      - LINESeedJP_OTF_Th.woff2
      - LINESeedJP_OTF_Rg.woff2
      - LINESeedJP_OTF_Bd.woff2
      - LINESeedJP_OTF_Eb.woff2
    - EOT/
      - LINESeedJP_TTF_Th.eot
      - LINESeedJP_TTF_Rg.eot
      - LINESeedJP_TTF_Bd.eot
      - LINESeedJP_TTF_Eb.eot
  - Desktop/
    - TTF/
      - LINESeedJP_TTF_Th.ttf
      - LINESeedJP_TTF_Rg.ttf
      - LINESeedJP_TTF_Bd.ttf
      - LINESeedJP_TTF_Eb.ttf
    - OTF/
      - LINESeedJP_OTF_Th.otf
      - LINESeedJP_OTF_Rg.otf
      - LINESeedJP_OTF_Bd.otf
      - LINESeedJP_OTF_Eb.otf

### 英語版

多分これが構造の基準だと思う

- LINE Seed Sans EN/
  - App/
    - TTF/
      - LINESeedSans_A_Th.ttf
      - LINESeedSans_A_Rg.ttf
      - LINESeedSans_A_Bd.ttf
      - LINESeedSans_A_XBd.ttf
      - LINESeedSans_A_He.ttf
    - OTF/
      - LINESeedSans_A_Th.otf
      - LINESeedSans_A_Rg.otf
      - LINESeedSans_A_Bd.otf
      - LINESeedSans_A_XBd.otf
      - LINESeedSans_A_He.otf
  - Web/
    - WOFF/
      - LINESeedSans_W_Th.woff
      - LINESeedSans_W_Rg.woff
      - LINESeedSans_W_Bd.woff
      - LINESeedSans_W_XBd.woff
      - LINESeedSans_W_He.woff
    - WOFF2/
      - LINESeedSans_W_Th.woff2
      - LINESeedSans_W_Rg.woff2
      - LINESeedSans_W_Bd.woff2
      - LINESeedSans_W_XBd.woff2
      - LINESeedSans_W_He.woff2
    - EOT/
      - LINESeedSans_W_Th.eot
      - LINESeedSans_W_Rg.eot
      - LINESeedSans_W_Bd.eot
      - LINESeedSans_W_XBd.eot
      - LINESeedSans_W_He.eot
  - Desktop/
    - TTF/
      - LINESeedSans_Th.ttf
      - LINESeedSans_Rg.ttf
      - LINESeedSans_Bd.ttf
      - LINESeedSans_XBd.ttf
      - LINESeedSans_He.ttf
    - OTF/
      - LINESeedSans_Th.otf
      - LINESeedSans_Rg.otf
      - LINESeedSans_Bd.otf
      - LINESeedSans_XBd.otf
      - LINESeedSans_He.otf

### 韓国語版

AppとDesktopの区別がない

韓国語版だけファイル名の区切りがなぜかハイフン

- LINE Seed Sans KR/
  - LINESeedSansKR_TTF/
    - LINESeedSansKR-Th.ttf
    - LINESeedSansKR-Rg.ttf
    - LINESeedSansKR-Bd.ttf
  - LINESeedSansKR_OTF/
    - LINESeedSansKR-Th.otf
    - LINESeedSansKR-Rg.otf
    - LINESeedSansKR-Bd.otf
  - LINESeedSansKR_Webfont/
    - woff/
      - LINESeedSansKR-Th.woff
      - LINESeedSansKR-Rg.woff
      - LINESeedSansKR-Bd.woff
    - woff2/
      - LINESeedSansKR-Th.woff2
      - LINESeedSansKR-Rg.woff2
      - LINESeedSansKR-Bd.woff2
    - eot/
      - LINESeedSansKR-Th.eot
      - LINESeedSansKR-Rg.eot
      - LINESeedSansKR-Bd.eot

### タイ語版

一番上のディレクトリ名が英語版と韓国語版に倣わずスペースをいれてない

- LINESeedSansTH/
  - App/
    - TTF/
      - LINESeedSansTH_A_Th.ttf
      - LINESeedSansTH_A_Rg.ttf
      - LINESeedSansTH_A_Bd.ttf
      - LINESeedSansTH_A_XBd.ttf
      - LINESeedSansTH_A_He.ttf
    - OTF/
      - LINESeedSansTH_A_Th.otf
      - LINESeedSansTH_A_Rg.otf
      - LINESeedSansTH_A_Bd.otf
      - LINESeedSansTH_A_XBd.otf
      - LINESeedSansTH_A_He.otf
  - Web/
    - WOFF/
      - LINESeedSansTH_W_Th.woff
      - LINESeedSansTH_W_Rg.woff
      - LINESeedSansTH_W_Bd.woff
      - LINESeedSansTH_W_XBd.woff
      - LINESeedSansTH_W_He.woff
    - WOFF2/
      - LINESeedSansTH_W_Th.woff2
      - LINESeedSansTH_W_Rg.woff2
      - LINESeedSansTH_W_Bd.woff2
      - LINESeedSansTH_W_XBd.woff2
      - LINESeedSansTH_W_He.woff2
    - EOT/
      - LINESeedSansTH_W_Th.eot
      - LINESeedSansTH_W_Rg.eot
      - LINESeedSansTH_W_Bd.eot
      - LINESeedSansTH_W_XBd.eot
      - LINESeedSansTH_W_He.eot
  - Desktop/
    - TTF/
      - LINESeedSansTH_Th.ttf
      - LINESeedSansTH_Rg.ttf
      - LINESeedSansTH_Bd.ttf
      - LINESeedSansTH_XBd.ttf
      - LINESeedSansTH_He.ttf
    - OTF/
      - LINESeedSansTH_Th.otf
      - LINESeedSansTH_Rg.otf
      - LINESeedSansTH_Bd.otf
      - LINESeedSansTH_XBd.otf
      - LINESeedSansTH_He.otf

