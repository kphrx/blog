Doc = Kramdown::Document

def is_page_or_post?(class_name)
  ["Jekyll::Page", "Jekyll::Document"].include?(class_name)
end

def is_markdown?(extname)
  [".markdown", ".mkdown", ".mkdn", ".mkd", ".md"].include?(extname)
end

def disabled_toc?(data)
  data["toc"] == false
end

def insert_toc(content, level, text)
  prefix = "#" * level
  header_reg = Regexp.new(prefix + " *?" + Regexp.escape(text))

  content.sub(header_reg, "{% include toc.md %}\n\n" + prefix + " " + text)
end

Jekyll::Hooks.register [:pages, :documents], :pre_render do |page, payload|
  next if disabled_toc?(page.data)
  next unless is_page_or_post?(page.class.name) and is_markdown?(page.extname)

  doc = Doc.new(page.content)
  children = doc.root.children
  first_header = children.detect { |element| element.type == :header }
  next if first_header.nil?

  payload["page"]["toc"] = true
  page.content = insert_toc(page.content, first_header.options[:level], first_header.options[:raw_text])
end
