require 'kramdown/converter/syntax_highlighter/rouge'

module RougeFormatFix
  def call(converter, text, lang, type, call_opts)
    opts = options(converter, type)
    call_opts[:default_lang] = opts[:default_lang]
    return nil unless lang || opts[:default_lang] || opts[:guess_lang]

    lexer = Rouge::Lexer.find_fancy(lang || opts[:default_lang], text)
    return call(converter, text, nil, type, call_opts) unless lexer
    return nil if opts[:disable] || (lexer.tag == "plaintext" && !opts[:guess_lang])

    opts[:css_class] ||= 'highlight' # For backward compatibility when using Rouge 2.0
    formatter = formatter_class(opts)
    formatter.format(lexer.lex(text))
  end

  def formatter_class(opts = {})
    formatter = super(opts)
    case
    when ["Rouge::Formatter",
          "Rouge::Formatters::HTML",
          "Rouge::Formatters::HTMLLegacy",
          "Rouge::Formatters::Tex",
          "Rouge::Formatters::Null"].include?(formatter.to_s)
      formatter.new(opts)

    when ["Rouge::Formatters::HTMLTable",
          "Rouge::Formatters::HTMLLinewise",
          "Rouge::Formatters::HTMLLineTable",
          "Rouge::Formatters::HTMLLineHighlighter"].include?(formatter.to_s)
      base_opts = opts.dup
      base_opts[:formatter] = base_opts.delete(:base_formatter) || Rouge::Formatters::HTML
      base_formatter = formatter_class(base_opts)
      formatter.new(base_formatter, opts)

    when ["Rouge::Formatters::HTMLInline",
          "Rouge::Formatters::Terminal256",
          "Rouge::Formatters::TerminalTruecolor"].include?(formatter.to_s)
      formatter.new(opts[:theme])

    when "Rouge::Formatters::HTMLPygments" === formatter.to_s
      base_opts = opts.dup
      base_opts[:formatter] = base_opts.delete(:base_formatter) || Rouge::Formatters::HTML
      base_formatter = formatter_class(base_opts)
      formatter.new(base_formatter, opts[:css_class])

    else
      formatter.new(opts)
    end
  end
end

Kramdown::Converter::SyntaxHighlighter::Rouge.singleton_class.prepend(RougeFormatFix)
