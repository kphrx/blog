module JekyllOcticonsReuseSymbol
  def render(context)
    @count ||= {}

    return nil if super(context).nil?

    page = context["page"]
    page_url = if page.key?(:url) then page.url else page["url"] end
    @count[page_url] ||= {}

    octicon = ::Octicons::Octicon.new(@symbol, @options)
    height = octicon.height
    @count[page_url][height] ||= 0
    @count[page_url][height] += 1

    if @count[page_url][height] > 1
      ::Octicons::Octicon.new(@symbol, @options).to_use_svg
    else
      ::Octicons::Octicon.new(@symbol, @options).to_symbol_use_svg
    end
  end
end

module OcticonSymbolUse
  def height
    @height
  end

  def to_symbol_use_svg
    "<svg #{html_attributes}><symbol id=\"octicon-#{@symbol}-#{@height}\" viewBox=\"#{viewbox}\">#{@path}</symbol><use href=\"#octicon-#{@symbol}-#{@height}\" /></svg>"
  end

  def to_use_svg
    "<svg #{html_attributes}><use href=\"#octicon-#{@symbol}-#{@height}\" /></svg>"
  end
end

Jekyll::Octicons.prepend(JekyllOcticonsReuseSymbol)
Octicons::Octicon.prepend(OcticonSymbolUse)
