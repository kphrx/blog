module FeedTemplateSource
  def feed_source_path
    @feed_source_path = '_layouts/feed.xml'
  end
end

JekyllFeed::Generator.prepend(FeedTemplateSource)
