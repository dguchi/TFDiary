module DiariesHelper
    def get_diary(date)
        Diary.find_by(date: date)
    end
end
