---
layout: default
title:  "preに行番号を追加してスクロールで動かないようにする"
date:   2018-10-12 18:08:07 +0900
categories: coding
---

preに行番号つけたかった。この方法でいくつも書くとするとCGIやJSに頼る必要があると思います

<!--more-->

このページのpreに適用しています。

## Demo
<style>
pre.line-number {
    overflow-y: hidden;
    line-height: 1.3em;
    position: relative;
    width: 100%;
    padding: 0;
    display: flex;
}
pre.line-number > code {
    overflow-x: auto;
    display: block;
    padding: .3em;
    flex: 1;
}
pre.line-number::before {
    background-color: rgba(186,186,186,0.1);
    content: "1\A";
    width: 2em;
    position: sticky;
    display: block;
    padding: .3em;
    padding-right: .5em;
    color: gray;
    font-weight: bold;
    text-align: right;
    word-wrap: break-word;
    white-space: pre-line;
}
pre.line-number-12::before {
    content: "1\A 2\A 3\A 4\A 5\A 6\A 7\A 8\A 9\A 10\A 11\A 12\A";
}
</style>
<pre class="line-number line-number-12">
<code>&lt;!document html&gt;
&lt;html&gt;
    &lt;head&gt;
        &lt;!-- sample code --&gt;
        &lt;title&gt;Hello, World!&lt;/title&gt;
    &lt;/head&gt;

    &lt;body&gt;
        &lt;h1&gt;Hello, World!&lt;/h1&gt;
        &lt;p&gt;Sticks and stones may break my bones, but word will never harm me.&lt;/p&gt;
    &lt;/body&gt;
&lt;/html&gt;</code>
</pre>

## Demo code
このDemoのHTMLとCSS

### HTML
```html
<pre class="line-number line-number-12">
<code>&lt;!document html&gt;
&lt;html&gt;
    &lt;head&gt;
        &lt;!-- sample code --&gt;
        &lt;title&gt;Hello, World!&lt;/title&gt;
    &lt;/head&gt;

    &lt;body&gt;
        &lt;h1&gt;Hello, World!&lt;/h1&gt;
        &lt;p&gt;Sticks and stones may break my bones, but word will never harm me.&lt;/p&gt;
    &lt;/body&amp;gt;
&lt;/html&gt;</code>
</pre>
```

### CSS
```css
pre.line-number {
    overflow-y: hidden;
    line-height: 1.3em;
    position: relative;
    width: 100%;
    padding: 0;
    display: flex;
}

pre.line-number > code {
    overflow-x: auto;
    display: block;
    padding: .3em;
    flex: 1;
}

pre.line-number::before {
    background-color: rgba(186,186,186,0.1);
    content: "1\A";
    width: 2em;
    position: sticky;
    display: block;
    padding: .3em;
    padding-right: .5em;
    color: gray;
    font-weight: bold;
    text-align: right;
    word-wrap: break-word;
    white-space: pre-line;
}

pre.line-number-12::before {
    content: "1\A 2\A 3\A 4\A 5\A 6\A 7\A 8\A 9\A 10\A 11\A 12\A";
}
```

## 実際の運用
この方法ではpreの行数が変わる度にCSSを書き換える必要がある。WordPressのカスタムCSSのような形で書き換えられるようにしてないと少し厳しい
各行をspanで囲ってカウンターで行数を表示する方が行数を調べる手間がかからないので楽だろうと思う
preの行数を自動でカウントするプラグインでも作って導入すればWordPressに関してはこの方法で十分か

## 謝辞
以下のサイトを参考にさせてもらいました
- [Pre に行番号を付ける方法 - MacoTrip](https://makotoiwasaki.com/2017/12/pre-line-number.html)
- [Pre CodeブロックにCSS擬似要素で行番号をつける方法 – StudioMic](https://www.studiomic.net/pre-line-numbers/)
