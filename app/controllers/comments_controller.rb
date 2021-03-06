class CommentsController < ApplicationController
  respond_to :html, :js
  # params = {topic_id: 1, post_id: 2, comment: {body: 'This is my comment'}}
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.find(params[:post_id])

    @comment = current_user.comments.new(params[:comment])
    # @comment.user = current_user
    @comment.post = @post

    authorize! :create, @comment, message: "You need to be signed up to do that."
    if @comment.save
      flash[:notice] = "Comment was saved."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render 'topics/posts/show'
    end
  end  
  



    def destroy
      @topic = Topic.find(params[:topic_id])
      @post = @topic.posts.find(params[:post_id])

      @comment = @post.comments.find(params[:id])
      authorize! :destroy, @comment, message: "You need to own the comment to delete it."
      if @comment.destroy
        flash[:notice] = "Comment was removed."
      else
        flash[:error] = "Comment couldn't be deleted. Try again."
      end

      respond_with(@comment) do |f|
        f.html { redirect_to [@topic, @post] }
      end
    end
  end

