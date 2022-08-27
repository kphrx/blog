---
date:       2018-11-07 19:15:36 +0900
category:   coding
---

# macOS MojaveでSwift 4.2 + Scripting Bridge

NowPlayingTweetで利用しているScripting Bridgeが、Mojaveからユーザーに許可をもらわないと利用できないようにセキュリティが強化されているのでその許可を求める方法とか

<!--more-->


## 記事中で作るもの
SwiftでiTunesの再生中の楽曲情報を取得するだけのものです  
Scripting Bridgeで値を取得するフレームワークはGitHubに転がってるので利用します。今回は[MichaelRow/PlayerBridge \| GitHub](https://github.com/MichaelRow/PlayerBridge)を利用します。フレームワークについては割愛

## Apple Eventsの許可を求める

### `Info.plist` に値を追加
AppleScript、つまりApple Eventsの機能を利用するということを `Info.plist` で示す。 `NSAppleEventsUsageDescription` というキーに `String` で `This script needs to control other applications to run.` と入れる

### EntitlementsにiTunesへのアクセス権を追加
Scripting BridgeでiTunesへアクセスするためにどの権限を利用するかをentitlementsへ記入します  
今回は再生中の楽曲のタイトルを取得できればよしとするので
1. `Dictionary` 型で `com.apple.security.scripting-targets` というキーに `Array` の `com.apple.iTunes` を追加
2. `com.apple.iTunes` に `com.apple.iTunes.playback` を追加する

権限は次のコマンドでxmlを出力して利用する `command` や `property` の `access-group` の `identifier` を参照してください
```sh
sdef /Applications/iTunes.app > itunes.sdef.xm
```

今回利用するのは `current track` なので以下の部分を参照します
```xml
<property name="current track" code="pTrk" type="track" access="r" description="the current targeted track">
    <access-group identifier="com.apple.iTunes.playback" access="r"/>
</property>
```

### アプリ内で権限を確認
Mojaveから必要になったものです。後方互換性を維持するのであれば `if #available(macOS 10.14, *)` で要求するようにしてください

`NSAppleEventDescriptor(bundleIdentifier: "com.apple.iTunes")` でiTunesのDescriptorを初期化。`AEDeterminePermissionToAutomateTarget` でAutomationのアクセス権を確認します  
アクセス権を要求するには第四引数を `true` にしてください。しかし第四引数が `true` でもアラートが出るのは初回のみなので、2回目以降に権限がないときは有効にする方法をユーザーへ提示する必要があります

戻り値は4種類ありますが権限を要求するのであれば知っておく必要があるのは以下の3つです

- `procNotFound = -600` はアクセス権を確認及び要求しようとしているアプリ（ここではiTunes）が起動していないことを表す値です  
<https://developer.apple.com/documentation/coreservices/procnotfound>
- `errAEEventNotPermitted = -1743` はアクセス権を要求したことがあるアプリで現在拒否されていることを表す値です  
<https://developer.apple.com/documentation/coreservices/erraeeventnotpermitted>
- `noErr = 0` はアクセス権を保有していることを表します  
<https://developer.apple.com/documentation/kernel/1645412-anonymous/noerr>

グローバルな定数ですが `noErr` のみ `OSStatus` 型で他は数値型なので以下のサンプルのように条件分岐させるときは `OSStatus(procNotFound)` とする必要があります
一つ注意が必要で、要求するアプリが起動していない時にはAutomationの権限を要求するアラートは出ません。ただ `procNotFound` が返ってくるだけなのでそれを考慮してください

```swift
@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let targetAEDescriptor: NSAppleEventDescriptor = NSAppleEventDescriptor(bundleIdentifier: "com.apple.iTunes")
        let status: OSStatus = AEDeterminePermissionToAutomateTarget(targetAEDescriptor.aeDesc, typeWildCard, typeWildCard, true)

        var isRunning: Bool = false
        var hasPermission: Bool = false

        switch status {
          case noErr:
            isRunning = true
            hasPermission = true
          case OSStatus(errAEEventNotPermitted):
            isRunning = true
          case OSStatus(procNotFound), _:
            break
        }

        if !isRunning {
            let alert = NSAlert(message: "iTunesが起動していません。アプリを終了します",
                                style: .warning)
            alert.runModal()
            NSApplication.shared().terminate(self)
            return
        }

        if !hasPermission {
            let alert = NSAlert(message: "iTunesへのアクセスが拒否されています。環境設定のセキュリティとプライバシー＞プライバシー＞オートメーションからこのアプリにiTunesへのアクセスを許可してください。アプリを終了します",
                                style: .warning)
            alert.runModal()
            NSApplication.shared().terminate(self)
            return
        }
    }

}
```

## 楽曲情報を取得する
許可を求めることが出来ればあとは今までと変わりません。今回はPlayerBridgeを利用しているので `iTunesBridge` をimportして再生中の楽曲情報を `iTunesApplication` クラスから取得します
```swift
import ScriptingBridge

// PlayerBridgeのiTunes用のフレームワーク
import iTunesBridge

/* ... */

guard let itunes: iTunesApplication = SBApplication(bundleIdentifier: "com.apple.iTunes") as? iTunesApplication, let currentTrack: iTunesTrack = itunes.currentTrack else {
    let alert = NSAlert(message: "再生中の楽曲はありません",
                                style: .informational)
    alert.runModal()
    return
}

let alert = NSAlert(message: currentTrack.title!,
                    style: .informational)
alert.runModal()
```

## 締め
以上、macOS 10.14 MojaveからSwift 4.2でScripting Bridgeを用いて他のアプリケーションの情報を取得したり操作する手順でした  
既存のコードで楽曲情報を取得できなくなっていて少し手間取りましたが、Mojaveの仕様に沿うように修正するのに必要な部分は少しでした。 `procNotFound` で起動チェックが出来るので、後方互換を気にしなければ別の起動チェックを省けていいかもしれません

## 関連
[NowPlayingを自動でツイートするMacアプリ](2018-02-06-nowplaying-tweet-for-mac.md)

