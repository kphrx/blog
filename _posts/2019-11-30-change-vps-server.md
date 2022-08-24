---
date:       2019-11-30 00:18:33 +0900
category:   blog

title: |
  サーバーを引っ越した話
---

サーバーを "さくらのVPS" に移したついでに環境も一新した

<!--more-->

{% include toc.md %}

## さくらのVPSについて
最近バージョンがアップしたか何かで値段がちょっと安くなっていて、『Nintendo Switch』が当たるみたいなキャンペーンもあったのでちょっと使ってみようかなと言う感じに

以前お試しで使ったことはあったのだけれど、ちょっと使いづらいと言うかなんと言うか…みたいな印象を持っていた  
今回契約して使ってるけど全然そんなことなくてConoHaとあまり変わらないかなって感じ

値段は少しだけだけれども、ConoHa VPSよりも安いし、年払いにすれば1ヶ月分浮くので常時稼働することが前提であればお得かなと言う感じ  
私はサーバーを潰してまた建てて……といった使い方じゃなくて常時起動の使い方をしているのでこちらの方がかなりコストが下がる

ConoHaはいいなって思うけど、APIでガンガン鯖立ててスケールするとか（コンセプトがVPSとクラウドのいいとこ取りだっけ？）、外部に公開する必要のないテストサーバーとかを一時的に立ち上げるて時間単位の請求で済ますとか、そういった用途に使うのがいいかなぁって思う

さくらの方はなんと言うかスケールは気楽には出来なさそうなのでクラウドみたいな使い方を考えるときはさくらのクラウドとかの方を検討した方がいいかも

## サーバー環境
ConoHa VPSの1GBプランを契約していました。現在さくらのVPSの512MBプランを契約しています。スペックが対応するものじゃないので性能比較とかは出来ません

OSと `cat /proc/cpuinfo` の結果を載せておきます

- ConoHa VPS 1GBプラン
   <dl>
     <dt>OS</dt>
     <dd>Ubuntu 16.04 -> do-release-upgradeでUbuntu 18.04に更新</dd>
   </dl>
   <dl>
     <dt markdown="1">

     `cat /proc/cpuinfo`
     </dt>
     <dd markdown="1">

   ```
   processor	: 0
   vendor_id	: GenuineIntel
   cpu family	: 6
   model		: 63
   model name	: Intel(R) Xeon(R) CPU E5-2660 v3 @ 2.60GHz
   stepping	: 2
   microcode	: 0x1
   cpu MHz		: 2599.996
   cache size	: 4096 KB
   physical id	: 0
   siblings	: 1
   core id		: 0
   cpu cores	: 1
   apicid		: 0
   initial apicid	: 0
   fpu		: yes
   fpu_exception	: yes
   cpuid level	: 13
   wp		: yes
   flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon rep_good nopl cpuid tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm invpcid_single pti fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
   bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs itlb_multihit
   bogomips	: 5199.99
   clflush size	: 64
   cache_alignment	: 64
   address sizes	: 46 bits physical, 48 bits virtual
   power management:

   processor	: 1
   vendor_id	: GenuineIntel
   cpu family	: 6
   model		: 63
   model name	: Intel(R) Xeon(R) CPU E5-2660 v3 @ 2.60GHz
   stepping	: 2
   microcode	: 0x1
   cpu MHz		: 2599.996
   cache size	: 4096 KB
   physical id	: 1
   siblings	: 1
   core id		: 0
   cpu cores	: 1
   apicid		: 1
   initial apicid	: 1
   fpu		: yes
   fpu_exception	: yes
   cpuid level	: 13
   wp		: yes
   flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon rep_good nopl cpuid tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm invpcid_single pti fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt
   bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs itlb_multihit
   bogomips	: 5199.99
   clflush size	: 64
   cache_alignment	: 64
   address sizes	: 46 bits physical, 48 bits virtual
   power management:
   ```
     </dd>
   </dl>

- さくらのVPS 512MBプラン
   <dl>
     <dt>OS</dt>
     <dd>Debian 10</dd>
   </dl>
   <dl>
     <dt markdown="1">

     `cat /proc/cpuinfo`
     </dt>
     <dd markdown="1">

   ```
   processor	: 0
   vendor_id	: GenuineIntel
   cpu family	: 6
   model		: 85
   model name	: Intel(R) Xeon(R) Gold 6212U CPU @ 2.40GHz
   stepping	: 7
   microcode	: 0x1
   cpu MHz		: 2399.998
   cache size	: 4096 KB
   physical id	: 0
   siblings	: 1
   core id		: 0
   cpu cores	: 1
   apicid		: 0
   initial apicid	: 0
   fpu		: yes
   fpu_exception	: yes
   cpuid level	: 13
   wp		: yes
   flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon rep_good nopl cpuid tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single ssbd ibrs ibpb stibp ibrs_enhanced fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm mpx avx512f avx512dq rdseed adx smap clflushopt clwb avx512cd avx512bw avx512vl xsaveopt xsavec xgetbv1 pku ospke avx512_vnni md_clear arch_capabilities
   bugs		: spectre_v1 spectre_v2 spec_store_bypass swapgs
   bogomips	: 4799.99
   clflush size	: 64
   cache_alignment	: 64
   address sizes	: 46 bits physical, 48 bits virtual
   power management:
   ```
     </dd>
   </dl>

## サーバー引っ越しに伴うドメインの変更等
サーバーを引っ越ししたことでドメインの変更を進めたりしたのでそれを記録

### ブログのドメインの変更、CMSの変更
まずはここ。みてすぐ判る通り、ドメインが変わり、デザインが簡素になってます  
今までWordPressを使ってブログをホストしていましたが、サーバー引っ越しに伴いPHPを利用しない形でブログをホストすることにしました

現在はJekyll on GitHub Pagesで動いています。使い勝手とかが悪くなければ今後もここに置いたままにしますが何か不都合ができたり他にいいホスティングサービスが見つかるなどすれば移転を考えています

そしてドメインですが、'19に入って `kpherox.dev` のドメインを取得していていたのでこれを機にWebサイトのすべてドメインを変更。サーバーを引っ越す前まではPleromaのドメインにしか使っていませんでした。（`kpherox.github.io` に `github.kpherox.dev` を使うようにしてたけど仮にあててただけ）

### Laravel製の自作アプリ
Laravelなので当然PHPです。これは旧サーバーと共に破棄される予定です

短縮URL（[kPherox/URL-Shortener \| GitHub](https://github.com/kPherox/URL-Shortener)） と気象庁XML電文購読アプリ（[kPherox/JMA-Publish-Sharer \| GitHub](https://github.com/kPherox/JMA-Publish-Sharer)）ですが、短縮URLは統計を取っていないので利用価値がとても低いのと、気象庁XMLの方は近々無料でのPush配信が終了するので稼働する意味が薄いと感じるためです

それぞれ最近の開発が止まってしまっていて、今後保守する意思もないのでGitHubのリポジトリもアーカイブすることにします

### Pleroma
さっき名前を挙げましたが、PleromaをConoHa VPSの時はホストOSにerlangを入れてsystendで `mix phx.server` していたのを、さくらのVPSではDockerで運用する形にしました。ついでにNGINXもDocker運用です

今までDocker他のコンテナ技術をちゃんと触れていないのでこれを機にホストを汚さないコンテナでの運用を勉強できればいいなと言う感じ

### その他
NGINXをDockerで運用するにあたって、Qiitaに書いた記事（[acme-dnsを使ってLet's Encryptのワイルドカード証明書を更新する - Qiita](https://qiita.com/kPherox/items/77e97874e8b83d61b1cd)）みたいなことはできないのでワイルドカード証明書ではなく通常の証明書になりました

それと今までNGINXとPHPをソースからビルドしていたのもやめる事になったのでngx-pagespeedみたいなモジュールとかもなくなりました

## 終
特にオチもないけど

ドメインを移すに当たってGoogle DomainsのDNSで合成レコードを発行してます  
適当にSSL証明書発行して301リダイレクトしてくれるのとてもありがたい

<dl>
  <dt>旧ドメイン</dt>
  <dd>blog.kr-kp.com</dd>
</dl>
<dl>
  <dt>新ドメイン</dt>
  <dd>blog.kpherox.dev</dd>
</dl>

## not written yet... 新サーバーの環境構築
一応pleromaに[#kpherox_環境構築メモ](https://pl.kpherox.dev/tag/kpherox_環境構築メモ)ってタグでちょっと書いてる。あとで書く（別記事になるかも）

