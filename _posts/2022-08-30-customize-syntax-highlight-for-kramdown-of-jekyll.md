---
category: Technology
tags: Jekyll
date: '2022-08-30 05:12:18 +0900'
redirect_from:
  - /tech/customize-syntax-highlight-for-kramdown-of-jekyll
  - /coding/customize-syntax-highlight-for-kramdown-of-jekyll
hasCodeSnippet: true
---
# Jekyll v4 の syntax highlight に Rouge::Formatters::HTMLLinewise を使えるようにする

GitHub Pages が Actions からデプロイできるようになって `ruby/setup-ruby` を使えば自由に `_plugins` の使用ができるようになったので、素の Kramdown だと利用できない Hash ではない引数が必要な `Rouge::Formatters` を使えるようにモンキーパッチをあてる。

<!--more-->

デフォルトで使われる `Rouge::Formatters::HTMLLegacy` は行番号をつけると `Rouge::Formatters::HTMLTable` を呼び出し `<table>` でレイアウトするため、コードブロックが `pre > code table tbody pre` のような階層になり、行番号が要素の属性ではなくテキストとして含まれてしまいマークアップとして汚くなるので、 `Rouge::Formatters::HTMLLinewise` を使いたい。


## 環境
- jekyll (4.2.2)
- kramdown (2.4.0)
- rouge (3.30.0)

## マークアップ

### 最初の設定

```yaml?filename=_config.yml
markdown: kramdown
highlighter: rouge

kramdown:
  input: GFM
  syntax_highlighter: rouge

  syntax_highlighter_opts:
    css_class: highlight
    block:
      formatter: HTMLLinewise
      tag_name: span
      class: line
```

````md?filename=index.md
---
layout: default
---

```
sample
code block
```
````

行番号が必要なのは block だけなので `:kramdown, :syntax_highlighter_opts, :block` の `:formatter` に HTMLLinewise を指定して `:tag_name` と `:class` を設定する。

```console?prompt=$
$ bundle exec jekyll build --trace
Configuration file: ./sample-jekyll/_config.yml
            Source: ./sample-jekyll
       Destination: ./sample-jekyll/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 
  Conversion error: Jekyll::Converters::Markdown encountered an error while converting 'index.md':
                    undefined method `stream' for {:css_class=>"highlight", :default_lang=>"plaintext", :guess_lang=>true, :formatter=>"HTMLLinewise", :tag_name=>"span", :class=>"line"}:Hash @formatter.stream(line_tokens) {|formatted| yield formatted } ^^^^^^^ Did you mean? store
bundler: failed to load command: jekyll (/usr/local/lib/ruby/gems/3.0.0/bin/jekyll)
/usr/local/lib/ruby/gems/3.0.0/gems/rouge-3.30.0/lib/rouge/formatters/html_linewise.rb:16:in `block in stream': undefined method `stream' for {:css_class=>"highlight", :default_lang=>"plaintext", :guess_lang=>true, :formatter=>"HTMLLinewise", :tag_name=>"span", :class=>"line"}:Hash (NoMethodError)

          @formatter.stream(line_tokens) {|formatted| yield formatted }
                    ^^^^^^^
Did you mean?  store
	from /usr/local/lib/ruby/gems/3.0.0/gems/rouge-3.30.0/lib/rouge/formatter.rb:99:in `block (2 levels) in token_lines'
// ...
	from /usr/local/lib/ruby/gems/3.0.0/gems/kramdown-2.4.0/lib/kramdown/converter/syntax_highlighter/rouge.rb:34:in `call'
```

`Rouge::Formatters::HTMLLinewise.new/1` に `:syntax_highlighter_opts` を渡してしまうため使えない。


### `Kramdown::Converter::SyntaxHighlighter::Rouge` にモンキーパッチをあてる

`Kramdown::Converter::SyntaxHighlighter::Rouge.call/5`([rouge.rb#L24-L35](https://github.com/gettalong/kramdown/blob/REL_2_4_0/lib/kramdown/converter/syntax_highlighter/rouge.rb#L24-L35)) で `formatter_class(opts).new(opts)` している部分を変更して `.singleton_class.prepend/1` する。

```ruby?filename=_plugins/kramdown-syntax-highlight-patch.rb
require 'kramdown/converter/syntax_highlighter/rouge'

module KramdownSyntaxHighlighterFix
  def call(converter, text, lang, type, call_opts)
    opts = options(converter, type)
    call_opts[:default_lang] = opts[:default_lang]
    return nil unless lang || opts[:default_lang] || opts[:guess_lang]

    lexer = ::Rouge::Lexer.find_fancy(lang || opts[:default_lang], text)
    return nil if opts[:disable] || !lexer || (lexer.tag == "plaintext" && !opts[:guess_lang])

    opts[:css_class] ||= 'highlight'
    formatter = new_formatter(formatter_class(opts), opts) # initialize 呼び出しを包む
    formatter.format(lexer.lex(text))
  end

  # 既知の Rouge:Formatters の initialize 引数の形式で出し分ける
  def new_formatter(formatter, opts)
    case
    when "Rouge::Formatters::HTMLInline" === formatter.to_s
      formatter.new(opts.fetch([:inline_theme], 'github'))

    when ["Rouge::Formatters::Terminal256",
          "Rouge::Formatters::TerminalTruecolor"].include?(formatter.to_s)
      opts[:theme] ? formatter.new(opts[:theme]) : formatter.new()

    when "Rouge::Formatters::HTMLPygments" === formatter.to_s
      formatter.new(base_formatter(opts), opts.fetch(:css_class, 'codehilite'))

    when ["Rouge::Formatters::HTMLTable",
          "Rouge::Formatters::HTMLLinewise",
          "Rouge::Formatters::HTMLLineTable",
          "Rouge::Formatters::HTMLLineHighlighter"].include?(formatter.to_s)
      formatter.new(base_formatter(opts), opts)

    else
      # Rouge::Formatter
      # Rouge::Formatters::HTML
      # Rouge::Formatters::HTMLLegacy
      # Rouge::Formatters::Tex
      # Rouge::Formatters::Null
      formatter.new(opts)
    end
  end

  def base_formatter(opts)
    opts[:inline_theme] ? Rouge::Formatters::HTMLInline.new(opts[:inline_theme])
                        : Rouge::Formatters::HTML.new
  end
end

Kramdown::Converter::SyntaxHighlighter::Rouge.singleton_class.prepend(KramdownSyntaxHighlighterFix)
```

これで各行が `<span class=line>` `\n</span>` で囲われてマークアップされた index.html が生成される

```console
$ bundle exec jekyll build --trace
Configuration file: ./sample-jekyll/_config.yml
            Source: ./sample-jekyll
       Destination: ./sample-jekyll/_site
 Incremental build: disabled. Enable with --incremental
      Generating... 
     Build Warning: Layout 'default' requested in index.md does not exist.
                    done in 0.134 seconds.
 Auto-regeneration: disabled. Use --watch to enable.
```

```html?filename=_site/index.html
<div class="language-plaintext highlighter-rouge"><span class="line">sample
</span><span class="line">code block
</span></div>
```


### `Rouge::Formatters::HTMLPygments` で包む

`<pre><code>` で囲うために HTMLPygments を使う。 `Rouge::Formatters::HTMLLegacy` が `:wrap` を設定すると HTMLPygments を一番最後に使うので同じようにする。

```diff
--- a/_config.yml
+++ b/_config.yml
@@ -11,3 +11,4 @@
       formatter: HTMLLinewise
       tag_name: span
       class: line
+      wrap: true
```

```diff
--- a/_plugins/kramdown-syntax-highlighter-rouge-patch.rb
+++ b/_plugins/kramdown-syntax-highlighter-rouge-patch.rb
@@ -11,6 +11,9 @@
 
     opts[:css_class] ||= 'highlight'
     formatter = new_formatter(formatter_class(opts), opts) # initialize 呼び出しを包む
+    if opts[:wrap] && !formatter.is_a?(Rouge::Formatters::HTMLPygments)
+      formatter = Rouge::Formatters::HTMLPygments.new(formatter, opts.fetch(:css_class, 'codehilite'))
+    end
     formatter.format(lexer.lex(text))
   end
 
```

`div.highlight pre.highlight code` で囲われた結果が入る

```html?filename=_site/index.html
<div class="language-plaintext highlighter-rouge"><div class="highlight"><pre class="highlight"><code><span class="line">sample
</span><span class="line">code block
</span></code></pre></div></div>
```

### 未対応の言語でも行番号だけ表示する

```diff
--- b/_plugins/kramdown-syntax-highlighter-rouge-patch.rb
+++ c/_plugins/kramdown-syntax-highlighter-rouge-patch.rb
@@ -7,7 +7,9 @@
     return nil unless lang || opts[:default_lang] || opts[:guess_lang]
 
     lexer = ::Rouge::Lexer.find_fancy(lang || opts[:default_lang], text)
-    return nil if opts[:disable] || !lexer || (lexer.tag == "plaintext" && !opts[:guess_lang])
+    return nil if !lexer && !lang
+    return call(converter, text, nil, type, call_opts) unless lexer
+    return nil if opts[:disable] || (lexer.tag == "plaintext" && !opts[:guess_lang])
 
     opts[:css_class] ||= 'highlight'
     formatter = new_formatter(formatter_class(opts), opts) # initialize 呼び出しを包む
```

未対応の言語で `Rouge::Lexer` が `nil` を返した時に `:default_lang` でフォールバックする。


## スタイリング

HTML の出力はこれで完成なのであとは CSS で行番号などの表示を調整する。

### 行番号

以前、[preに行番号を追加してスクロールで動かないようにする](2018-10-12-add-line-number-to-pre-tag.md)方法を記事にした時に

> 各行を `span` で囲ってカウンターで行数を表示する方が行数を調べる手間がかからないので楽だろうと思う

と言っていたことそのままの CSS で実装できる。入れ子要素のセレクタはめんどくさいので SCSS 形式で記述する

```scss
$padding-y: 0.3em;
$padding-x: 1ex;

div.highlighter-rouge > div.highlight > pre.highlight {
  counter-reset: line-number; // コードブロックになるたびにカウンタをリセット

  overflow: auto;
  overscroll-behavior: none; // 端までスクロールして行番号が動かないように

  > code > span.line {
    counter-increment: line-number; // 行毎にカウンタをインクリメント
    padding-right: $padding-x;

    &::before {
      content: counter(line-number); // カウンタを出力する

      text-align: right;

      position: sticky; // 行番号を固定表示
      inset: 0;

      display: inline-block;
      box-sizing: border-box;
      width: 5ex;
      padding-right: 1ex;

      margin-right: $padding-x;
    }

    &:first-child::before {
      padding-top: $padding-y;
    }

    &:last-child::before {
      padding-bottom: $padding-y;
    }
  }
}
```

一切 CSS がかかってない環境ではこれで行番号が適切につき、 `pre` と `span.line::before` に `background-color`, `color` を指定すれば隙間なく綺麗な表示になる。

#### 行番号表示の切替

しかし、 `.language-console` などのようにファイルではない環境でも行番号が付くのは微妙なので先に行番号なしのスタイリングを行い、不要な言語を `:not()` 擬似クラスで無視して適用するようにする。

```scss
$padding-y: 0.3em;
$padding-x: 1ex;

div.highlighter-rouge {
  > div.highlight > pre.highlight {
    padding: $padding-y $padding-x;

    overflow: auto;

    > code {
      padding: 0;
      margin: 0;

      > span.line {
        padding-right: $padding-x;
      }
    }
  }

  &:not(.language-console):not(.language-terminal) > div.highlight > pre.highlight {
    counter-reset: line-number; // コードブロックになるたびにカウンタをリセット

    padding: 0; // padding をリセット。行番号に padding をつけない。

    overscroll-behavior: none; // 端までスクロールして行番号が動かないように

    > code > span.line {
      counter-increment: line-number; // 行毎にカウンタをインクリメント

      &::before {
        content: counter(line-number); // カウンタを出力する

        text-align: right;

        position: sticky; // 行番号を固定表示
        inset: 0;

        display: inline-block;
        box-sizing: border-box;
        width: 5ex;
        padding-right: 1ex;

        margin-right: $padding-x;
      }

      &:first-child::before {
        padding-top: $padding-y;
      }

      &:last-child::before {
        padding-bottom: $padding-y;
      }
    }
  }
}
```

これで console のときだけ行番号を表示しなくなる。


## まとめ

Kramdown で HTMLLinewise を使えるようにパッチをあてることで Jekyll でも可変長の行番号を静的に出力できるようになった。
GitHub Actions で `bundle exec jekyll build` の結果をそのままデプロイするようになって、雑に解決できる方法が使えるようになったのが嬉しい。

モンキーパッチでどうにかしていくのはあまり良くないと思うので正攻法というか一番いいのは Formatter のプロトコルをちゃんと実装して
Rouge に投げることだとは思うから気が向いたらやってみよう。
