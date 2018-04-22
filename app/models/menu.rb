class Menu < ActiveRecord::Base
    acts_as_followable

    validates :name, :presence => true
    validates :kind, :presence => true
    validates :author_id, :presence => true
    
    enum kind: {run: 0, jump: 1, throw: 2, drill: 3, other: 4}
    enum secret: {pub: false, pri: true}
end
