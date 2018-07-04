class Notice < ActiveRecord::Base
    belongs_to :user
    
    validates :msg, :presence => true
    validates :link, :presence => true
    validates :user_id, :presence => true
    
    def create_user_diary(user, link)
        self.msg = "#{user.name}さんが日誌を更新しました"
        self.link = link
        self.image_path = user.image.url
    end

    def create_user_favorite(user, link)
        self.msg = "#{user.name}さんがあなたをフォローしました"
        self.link = link
        self.image_path = user.image.url
    end

    def create_diary_favorite(user, link)
        self.msg = "#{user.name}さんがあなた日誌をいいねしました"
        self.link = link
        self.image_path = user.image.url
    end

    def create_diary_comment(user, link)
        self.msg = "#{user.name}さんがあなたの日誌にコメントしました"
        self.link = link
        self.image_path = user.image.url
    end

    def create_group_diary(group, link)
        self.msg = "#{group.name}グループからメニューが配信されました"
        self.link = link
        self.image_path = group.image.url
    end

    def create_group_addmember(group, user_name, link)
        self.msg = "#{group.name}グループに#{user_name}さんが加入しました"
        self.link = link
        self.image_path = group.image.url
    end

    def create_group_chat(group, link)
        self.msg = "#{group.name}グループのチャットに新規投稿がありました "
        self.link = link
        self.image_path = group.image.url
    end

    def create_group_updateinfo(group, link)
        self.msg = "#{group.name}グループの情報が更新されました"
        self.link = link
        self.image_path = group.image.url
    end
end
