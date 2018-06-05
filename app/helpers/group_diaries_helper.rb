module GroupDiariesHelper
    def get_diary_group(group, date)
        group.diaries.where(:date => date)
    end
    
end
