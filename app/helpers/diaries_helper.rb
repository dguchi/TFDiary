module DiariesHelper
    def get_diary(user, date)
        user.diaries.where(:date => date)
    end
    
    def get_menu(id)
        Menu.find(id)
    end
    
    def get_user(id)
        User.find(id)
    end
end
