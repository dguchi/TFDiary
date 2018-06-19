class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @diary = Diary.find(params[:diary_id])
    @comment = @diary.comments.build(comment_params)
    if @comment.save
      create_diary_comment_notice(view_context.current_user, @diary)
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

  # 日誌コメント時の通知
  def create_diary_comment_notice(user, diary)
    notice = User.find(diary.user_id).notices.build()
    notice.create_diary_comment(user.name, diary_path(diary.id))
    notice.save
  end
end
