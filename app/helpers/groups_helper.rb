module GroupsHelper
    def admin_user?(group_id, user_id)
        group = Group.find(group_id)
        (user_id == group.leader_id) || (user_id == group.subleader_id1) || (user_id == group.subleader_id2) || (user_id == group.subleader_id3)
    end
end
