class FavoriteMailer < ActionMailer::Base
  default from: "hollyp575@gmail.com"

  def new_comment(user, post, comment)
    @user = user
    @post = post
    @comment = comment

    #New Headers
    headers["Message-ID"] = "<comments/#{comment.id}@Hollys-rails-app>"
    headers["In-Reply-To"] = "<post/#{post.id}@Hollys-rails-app>"
    headers["References"] = "<post/#{@post.id}@Hollys-rails-app>"

    mail(to: user.email, subject: "New comment on #{post.title}")
  end
end

