class PagesController < PostsController
    #def about
    #    @title = "About"
    #end

    def profile
        @post = Post.includes(:user).where(user_id: params[:id]).order(id: :desc)
    end
end
