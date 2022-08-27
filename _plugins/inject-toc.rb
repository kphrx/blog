Doc = Kramdown::Document
Elm = Kramdown::Element

def is_markdown?(ext)
  [".markdown", ".mkdown", ".mkdn", ".mkd", ".md"].include?(ext)
end

def disabled?(data)
  data["toc"] == false
end

def insert_toc(content, level, text)
  prefix = "#" * level
  header_reg = Regexp.new(prefix + " *?" + Regexp.escape(text))

  return content.gsub(header_reg, "{% include toc.md %}\n\n" + prefix + " " + text)
end

Jekyll::Hooks.register :pages, :pre_render do |page|
  if page.class.name == "Jekyll::Page" and is_markdown?(page.extname) and not disabled?(page.data)
    doc = Doc.new(page.content)
    children = doc.root.children
    first_header = children.index {|element| element.type == :header }
    unless first_header.nil?
      first_header = children.fetch(first_index)
      page.content = insert_toc(page.content, first_header.options[:level], first_header.options[:raw_text])
    end
  end
end

Jekyll::Hooks.register :documents, :pre_render do |page, payload|
  if is_markdown?(page.extname) and not disabled?(page.data)
    doc = Doc.new(page.content)
    children = doc.root.children
    first_index = children.index {|element| element.type == :header }
    unless first_index.nil?
      first_header = children.fetch(first_index)
      page.content = insert_toc(page.content, first_header.options[:level], first_header.options[:raw_text])
    end
  end
end
