class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :show ]
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def show
    @post = Post.includes(:user, :attraction).find(params[:id])
    ref = params[:ref]
    increment_visit(@post)
    increment_ref(ref, @post)
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :published, :attraction_id)
  end

  def increment_ref(ref, post)
    IncrementRef.new(ref, post).call
  end

  def increment_visit(post)
    if post.visits.nil?
      post.visits = 1
    else
      post.visits += 1
    end
    post.save
  end
end
