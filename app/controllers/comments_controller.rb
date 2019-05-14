class CommentsController < ApplicationController

  def top_commenters
    @commenters = User.top_commenters
  end

  def create
    comment = Comment.new(comments_params)
    comment.user = current_user
    if comment.save
      redirect_to movie_path(comments_params[:movie_id]), notice: 'Comment has been added'
    else
      redirect_to movie_path(comments_params[:movie_id]), alert: 'Couldnt add a comment'
    end
  end

  def destroy
    comment = Comment.find_by(user: current_user, id: params[:id])
    if comment
      comment.destroy
      redirect_to movie_path(comment.movie), notice: 'Your comment has been deleted'
    else
      redirect_to movie_path(comment.movie), alert: 'Could not delete this comment'
    end
  end

  private

  def comments_params
    params.require(:comment).permit(:id, :content, :movie_id)
  end

end