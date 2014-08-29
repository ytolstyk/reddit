class PostsController < ApplicationController
  before_action :ensure_authored, only: [:edit, :update]

  def new
    @post = current_sub.posts.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.author = current_user
    
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def edit
    current_post
  end
  
  def update
    if current_post.update(post_params)
      redirect_to post_url(current_post)
    else
      flash.now[:errors] = current_post.errors.full_messages
      render :edit
    end
  end
  
  def show
    current_post
  end
  
  private
  
  def ensure_authored
    unless current_post.author == current_user
      flash[:errors] = ["You are not the author for #{ current_post.title }."]
      redirect_to post_url(current_post)
    end
  end
  
  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end
  
  def current_post
    @post ||= Post.find(params[:id])
  end
  
  def current_sub
    @sub ||= Sub.find(params[:sub_id])
  end
end
