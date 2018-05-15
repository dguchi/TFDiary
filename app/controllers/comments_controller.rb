class CommentsController < ApplicationController
  def create
    @diary = Diary.find(params[:diary_id])
    @comment = @diary.comments.build(comment_params)
    if @comment.save
      redirect_to diary_path(@diary.id)
    else
      render diary_path(@diary.id)
    end
  end
    
  def destroy
    @comment = Comment.find(params[:id])
    diary_id = @comment.diary_id
    @comment.destroy
    redirect_to diary_path(diary_id)
  end
  
private
  def comment_params
    params.require(:comment).permit(
      :user_id,
      :content
    )
  end
end
