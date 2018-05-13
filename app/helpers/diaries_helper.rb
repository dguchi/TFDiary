module DiariesHelper
    def get_diary(date)
        Diary.find_by(date: date)
    end
    
    def get_menu(id)
        Menu.find(id)
    end
end
