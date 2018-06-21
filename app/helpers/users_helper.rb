module UsersHelper
  def get_user(id)
    User.find(id)
  end
    
  def get_diaries(user)
    diaries = []
    if user.main_group_id
      group = Group.find(user.main_group_id)
      diaries = group.diaries.where(:date => Time.now.strftime("%Y-%m-%d"))
    else
      diaries = user.diaries.where(:date => Time.now.strftime("%Y-%m-%d"))
    end
    
    return diaries
  end
end
