class Notice < ActiveRecord::Base
    belongs_to :user
    
    validates :msg, :presence => true
    validates :link, :presence => true
    validates :user_id, :presence => true
    
    def create_user_diary(name, link)
        self.msg = "#{name}さんが日誌を更新しました"
        self.link = link
    end

    def create_user_favorite(name, link)
        self.msg = "#{name}さんがあなたをフォローしました"
        self.link = link
    end

    def create_diary_favorite(name, link)
        self.msg = "#{name}さんがあなた日誌をいいねしました"
        self.link = link
    end

    def create_diary_comment(name, link)
        self.msg = "#{name}さんがあなたの日誌にコメントしました"
        self.link = link
    end

    def create_group_diary(name, link)
        self.msg = "#{name}グループからメニューが配信されました"
        self.link = link
    end

    def create_group_addmember(name, user_name, link)
        self.msg = "#{name}グループに#{user_name}さんが加入しました"
        self.link = link
    end

    def create_group_chat(name, link)
        self.msg = "#{name}グループのチャットに新規投稿がありました "
        self.link = link
    end

    def create_group_updateinfo(name, link)
        self.msg = "#{name}グループの情報が更新されました"
        self.link = link
    end
end
