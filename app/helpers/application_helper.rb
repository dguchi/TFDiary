module ApplicationHelper
    def simple_time(time)
        time.strftime("%Y-%m-%d %H:%M")
    end
    
    def active?(action_name)
        return "active" if controller_name == params[:action]
    end
end
