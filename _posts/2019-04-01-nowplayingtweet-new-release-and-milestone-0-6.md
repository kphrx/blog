---
date:       2019-04-01 21:25:20 +0900
category:   blog
---

# NowPlayingTweet の新規リリースと 0.6 について

Issueが開かれて久々にソースコードを触ってたついでにユーザー数がそこそこいるというのを確認したので、自分が使うためのMastodon対応の意志を書いておく

<!--more-->


## 新規リリース (0.5.1)
この記事を書いてる今日、ある程度のサイズの画像がアートワークとして添付されるときにAPI上限を下回っていながらエラーになるというIssueが開かました  
["One of the uploaded media is too large" · Issue #9 · kPherox/NowPlayingTweet \| GitHub](https://github.com/kPherox/NowPlayingTweet/issues/9)

そのバグの修正をしたバージョンをリリースしました。以下からダウンロードできます  
[Release Version 0.5.1 · kPherox/NowPlayingTweet \| GitHub](https://github.com/kPherox/NowPlayingTweet/releases/tag/0.5.1)

これはScripting Bridgeで取ってきた `data` を `NSImage` から `Data` にするときに多分無駄な変換を挟んでしまっていたというのが問題になっていそうで、初めから `raw data` を利用する形にすることでAPI上限の5MB以下であれば多分大丈夫だろうという変更になります。正直よくわからないまま実装してるので違うかもしれない……

## Mastodon対応 (0.6)
今はマイクロブログをTwitterからMastodonに移してしまっているので。このアプリケーションをMastodonに対応させるっていうIssueは開いてはいたのですが、すぐに使えるわけじゃないし自然と使わずメンテもせずという形で放置していました  
正直なところ、今Mastodonを使っているTheDeskというクライアントで#NowPlayingを投稿できるしアートワーク付ける機能も私が対応させたので、このアプリの特徴はAuto Tweetだけになってしまった。自動でアートワーク付きNowPlayingを投稿するのは普通に迷惑になりそう（それに今後自分でインスタンス建てたときに多分やりたくない）なので対応させる必要を感じていないところがありました。と言った感じでやろうと思うもソースをいじる気が起きていませんでした

今回のバグ報告は有り難かったですし、Twitterで `source:NowPlaying_Tweet_for_Mac` の条件を付けて#NowPlayingを見ると結構使ってくれてる人がいるんですよね。GitHub APIでもRelease assetsの `download_count` がVersion 0.5では250を超えていて、さらに「開発者が使わなくなったOSSは廃れる」なんていう言葉も刺さってちょっと面倒見てやりたいなとなったわけです。というわけでmilestone 0.6にちゃんと着手しようと思います

## おわり
Milestone設定してたけどProjectの方が見やすいねこれ……という感じで移行したらIssueとPullRequestがすごいひどいからそこから直して気持ちよく開発したい……
