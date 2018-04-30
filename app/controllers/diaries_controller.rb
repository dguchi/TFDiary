class DiariesController < ApplicationController
  def new
    @diary = Diary.new
  end
  
  def create
    @diary = Diary.new(diary_params)
    if @diary.save
      redirect_to diary_path(@diary.id)
    else
      render :new
    end
  end

  def edit
  end
  
  def update
  end

  def index
  end

  def show
  end
  
private
  def diary_params
    params.require(:diary).permit(:date, :explain, :user_id)
  end
end
