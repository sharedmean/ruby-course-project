class PagesController < PostsController
    def about
        @title = "About"
    end

    def profile
        @post = Post.where(user_id: params[:id]).order(id: :desc)
    end
end
