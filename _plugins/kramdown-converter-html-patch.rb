
module AddDataAttributesToHighlighter
  def convert_codeblock(el, indent)
    attr = el.attr.dup
    lang = extract_code_language!(attr)
    hl_opts = {}
    highlighted_code = highlight_code(el.value, el.options[:lang] || lang, :block, hl_opts)

    if highlighted_code
      add_syntax_highlighter_to_class_attr(attr, hl_opts[:lang])
      "#{' ' * indent}<div#{html_attributes(attr)}>#{highlighted_code}#{' ' * indent}</div>\n"
    else
      super(el, indent)
    end
  end

  def convert_codespan(el, _indent)
    attr = el.attr.dup
    lang = extract_code_language(attr)
    hl_opts = {}
    result = highlight_code(el.value, lang, :span, hl_opts)
    if result
      add_syntax_highlighter_to_class_attr(attr, hl_opts[:lang])
    else
      result = escape_html(el.value)
    end

    format_as_span_html('code', attr, result)
  end
end

Kramdown::Converter::Html.prepend(AddDataAttributesToHighlighter)
