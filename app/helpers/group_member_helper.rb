module GroupMemberHelper
  def get_diaries_group(group)
    group.diaries.where(:date => Time.now.strftime("%Y-%m-%d"))
  end
  
  def active_setting?
    return "active" if ("setting" == params[:action]) || ("edit" == params[:action]) || ("assign_job" == params[:action]) || ("new" == params[:action])
  end
end
