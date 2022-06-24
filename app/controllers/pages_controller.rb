class PagesController < PostsController
  def profile
    @post = Post.includes(:user).where(user_id: params[:id]).order(id: :desc)
  end
end
