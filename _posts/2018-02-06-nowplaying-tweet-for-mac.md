---
date:       2018-02-06 00:00:54 +0900
category:   macos

title: |
  NowPlayingを自動でツイートするMacアプリ
---

制作物紹介です。NowPlayingTweetという名前のMacアプリです。記事タイトルの通り再生中の曲情報をTwitterへ共有するアプリになります  
なお、基本的に執筆時のもの（0.2.1）が基準となっています。更新漏れ等で変更されていない部分も混ざっていますがご容赦ください

<!--more-->

{% include toc.md %}

## システム要件
- Mac OS X 10.11 ~ macOS 10.14 (0.6以降は macOS 10.13+になる予定)

## インストール方法
Homebrew caskからインストールできるようにしてあります

また、私はApple Developer Programに加入していないので、初回起動時にアプリを開くことができません  
一度アプリを開こうとして開発元不明のダイアログを表示させた後、システム環境設定アプリのセキュリティ&プライバシーを開き、NowPlayingTweetを開けるようにしてください

### Homebrew cask
私の個人リポジトリがあるのでそこからhomebrew-caskを利用してインストールすることができます

homebrew-caskを入れてない方は、あらかじめ `brew tap homebrew/cask` を実行してcaskを使えるようにする必要があります

1. `kpherox/personal` をtapして私の個人リポジトリをbrewに追加

    ```sh
    brew tap kpherox/personal
    ```

2. `nowplayingtweet` をインストール

    ```sh
    brew cask install kpherox/personal/nowplayingtweet
    ```

### GitHub ReleasesからZipファイルをダウンロードする
1. [Release latest · kPherox/NowPlayingTweet \| GitHub](https://github.com/kPherox/NowPlayingTweet/releases/latest)から `NowPlayingTweet-<version>.zip` をダウンロード
2. ダウンロードしたファイルを展開して `/Applications` へ移動

執筆時点のバージョンは0.2.1です。最終更新の時点では0.5.1です

## 使用方法
NowPlayingTweetはDockに表示されるアプリではなくステータスバーに表示されるアプリです  
起動するとステータスバーに♫(音符)のアイコンが出ます。これをクリックすると表示されるメニューから操作します

### 初回の手順
1. **[Preferences…]** > **[Accounts]** を開いて +ボタン からアカウントを追加します。ブラウザが開きますのでNowPlayingTweetにTwitterアカウントへのアクセスを許可してください
2. アクセスを許可するとアプリへのリダイレクトが発生するので許可してください。その後NowPlayingTweetを開くとアカウントが追加されているはずです
3. **[Preferences…]** > **[Advanced]** の **[Auto Tweet]** にチェックを入れていると、iTunesで曲を再生、もしくは別の曲に変わった時にツイートされます

### その他機能
- メインメニューから手動ツイート
- マルチアカウント
- キーボードショートカットによる手動ツイート

## 最後に
正式版リリースを目指してしばらく開発を続けようかなと思います。アプリのアイコンどうしようかなぁ……

[今後の予定](2019-04-01-nowplayingtweet-new-release-and-milestone-0-6.md#mastodon対応-06)に書いていますが次のバージョンではMastodonやPleroma、MisskeyといったActivityPubプロトコルを使って連合している分散型SNSへの投稿もできるようにしようとしています。~~設計に躓いて開発止まってますが……~~  
バグ修正や小さな機能の追加等はパッチバージョンで続けて行くつもりなので挙動にバグがあるとかがあればGitHub Issueとかに書いてくれると嬉しいです
