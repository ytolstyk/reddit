module PostsHelper
  def post_title(post)
    post.url == "" ? post.title : link_to(post.title, post.url)
  end
end
