module ApplicationHelper
    def simple_time(time)
        time.strftime("%Y-%m-%d %H:%M")
    end
    
    def active?(controller, action)
        return "active" if (controller == params[:controller]) && (action == params[:action])
    end
    
    def active_action?(action_name)
        return "active" if action_name == params[:action]
    end
end
