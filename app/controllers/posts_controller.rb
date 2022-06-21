class PostsController < ApplicationController
  def index
    # select * from posts where post.user_id
    follows = current_user.following_follows.select('following_id')
    @posts = Post.includes(:user).where("user_id in (?)", follows).limit(50).order(id: :desc)
    # @posts = Post.includes(:user).all.limit(50).order(id: :desc)
  end

  def new # if you wanna check all actions from resources: 'rake routes'
    @post = Post.new
  end 

  def show
    @post= Post.find(params[:id])
  end

  def edit
    @post= Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post

    if @post.update(post_params)
      redirect_to post_path(@post) # calls 'show'
    else
      render :edit # rerender the current page
    end
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if(@post.save)
      redirect_to @post # calls 'show'
    else
      render :new # rerender the current page
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    authorize @post
    @post.picture.remove!
    @post.destroy
    redirect_to home_path # home_path == posts_path
  end

  private def post_params
    params.require(:post).permit(:title, :body, :picture)
  end
end
