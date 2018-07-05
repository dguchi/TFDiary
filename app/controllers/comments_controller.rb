class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :comment_destroy_user!, :only => [:destroy]
  
  def create
    @diary = Diary.find(params[:diary_id])
    @comment = @diary.comments.build(comment_params)
    if @comment.save
      create_diary_comment_notice(view_context.current_user, @diary)
    else
      flash[:alert] = "コメント内容を入力してください"
    end

    redirect_to diary_path(@diary.id)
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

  def comment_destroy_user!
    comment = Comment.find(params[:id])
    unless comment.user_id == view_context.current_user.id
      redirect_to diary_path(comment.diary_id)
    end
  end

  # 日誌コメント時の通知
  def create_diary_comment_notice(user, diary)
    latest = user.notices.order(created_at: :desc).first
    notice = User.find(diary.user_id).notices.build()
    notice.create_diary_comment(user, diary_path(diary.id))
    unless latest&.msg == notice.msg
      notice.save
    end
  end
end
