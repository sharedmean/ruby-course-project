class PostMailer < ApplicationMailer
    default from: 'blog@example.com'

    def new_post_email() # we may give here user_email and send to: user_email
        @post = params[:post]
        mail(to: 'skor.julia@bk.ru', subject: 'New post')
    end

    def edit_post_email() # we may give here user_email and send to: user_email
        @post = params[:post]
        mail(to: 'skor.julia@bk.ru', subject: 'Post updated')
    end
end