class PostsController < ApplicationController
  def index
    @post = Post.all.limit(50).order(id: :desc)
  end

  def new # if you wanna check all actions from resources: 'rake routes'
    @post = Post.new
  end 

  def show
    @post= Post.find(params[:id])
  end

  def edit
    @post= Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if(@post.update(post_params))
      redirect_to post_path(@post) # calls 'show'
    else
      render 'edit' # rerender the current page
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    if(@post.save)
      redirect_to @post # calls 'show'
    else
      render 'new' # rerender the current page
    end
  end

  def destroy
    @post = Post.find(params[:id])

    @post.destroy
    redirect_to home_path # home_path == posts_path
  end

  private def post_params
    params.require(:post).permit(:title, :body, :picture)
  end
end
