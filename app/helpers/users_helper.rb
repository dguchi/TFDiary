module UsersHelper
    def get_user(id)
        User.find(id)
    end
end
