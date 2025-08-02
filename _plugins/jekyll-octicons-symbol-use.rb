module JekyllOcticonsReuseSymbol
  def render(context)
    @count ||= {}

    return nil if super(context).nil?

    page = context["page"]
    page_url = if page.key?(:url) then page.url else page["url"] end
    @count[page_url] ||= 0
    @count[page_url] += 1

    if @count[page_url] > 1
      ::Octicons::Octicon.new(@symbol, @options).to_use_svg
    else
      ::Octicons::Octicon.new(@symbol, @options).to_symbol_use_svg
    end
  end
end

module OcticonSymbolUse
  def to_symbol_use_svg
    "<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" #{html_attributes}><symbol id=\"octicon-#{@symbol}\" viewBox=\"#{viewbox}\">#{@path}</symbol><use xlink:href=\"#octicon-#{@symbol}\" /></svg>"
  end
  def to_use_svg
    "<svg xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" #{html_attributes}><use xlink:href=\"#octicon-#{@symbol}\" /></svg>"
  end
end

Jekyll::Octicons.prepend(JekyllOcticonsReuseSymbol)
Octicons::Octicon.prepend(OcticonSymbolUse)
