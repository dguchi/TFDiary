module GroupsHelper
    def admin_user?(group_id, user_id)
        group = Group.find(group_id)
        (user_id == group.leader_id) || (user_id == group.subleader_id1) || (user_id == group.subleader_id2) || (user_id == group.subleader_id3) || (user_id == group.manager_id1) || (user_id == group.manager_id2)
    end
    
    def get_group(group_id)
        Group.find(group_id)
    end
    
    def group_leader?(user_id)
        ret = false
        if Group.find_by(:leader_id => user_id)
            ret = true
        end
        
        ret
    end
end
