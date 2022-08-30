require 'kramdown/converter/syntax_highlighter/rouge'

module KramdownSyntaxHighlighterFix
  def call(converter, text, lang, type, call_opts)
    opts = options(converter, type)
    call_opts[:default_lang] = opts[:default_lang]
    return nil unless lang || opts[:default_lang] || opts[:guess_lang]

    lexer = Rouge::Lexer.find_fancy(lang || opts[:default_lang], text)
    return nil if !lexer && !lang
    return call(converter, text, nil, type, call_opts) unless lexer
    return nil if opts[:disable] || (lexer.tag == "plaintext" && !opts[:guess_lang])

    call_opts[:lang] = lexer.tag

    opts[:css_class] ||= 'highlight'
    formatter = new_formatter(formatter_class(opts), opts) # initialize 呼び出しを包む
    if opts[:wrap] && !formatter.is_a?(Rouge::Formatters::HTMLPygments)
      formatter = Rouge::Formatters::HTMLPygments.new(formatter, opts.fetch(:css_class, 'codehilite'))
    end
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
