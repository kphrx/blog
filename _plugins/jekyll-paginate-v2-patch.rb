module AutoPagesFixCollections
  def ap_index_posts_by(all_posts, index_key)
    return super(all_posts, index_key) if index_key != '__coll'

    super(all_posts.select do |post|
      post.data[index_key] != 'posts'
    end, index_key)
  end
end

Jekyll::PaginateV2::AutoPages::Utils.singleton_class.prepend(AutoPagesFixCollections)
