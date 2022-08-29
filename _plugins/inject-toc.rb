Doc = Kramdown::Document

def is_page_or_post?(class_name)
  ["Jekyll::Page", "Jekyll::Document"].include?(class_name)
end

def is_markdown?(extname)
  [".markdown", ".mkdown", ".mkdn", ".mkd", ".md"].include?(extname)
end

def disabled?(data)
  data["toc"] == false
end

def insert_toc(content, level, text)
  prefix = "#" * level
  header_reg = Regexp.new(prefix + " *?" + Regexp.escape(text))

  content.sub(header_reg, "{% include toc.md %}\n\n" + prefix + " " + text)
end

Jekyll::Hooks.register [:pages, :documents], :pre_render do |page|
  if is_page_or_post?(page.class.name) and is_markdown?(page.extname) and not disabled?(page.data)
    doc = Doc.new(page.content)
    children = doc.root.children
    first_index = children.index {|element| element.type == :header }
    unless first_index.nil?
      first_header = children.fetch(first_index)
      page.content = insert_toc(page.content, first_header.options[:level], first_header.options[:raw_text])
    end
  end
end
