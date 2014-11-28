class Item < ActiveRecord::Base
    belongs_to :list

    #attr_accessible :done

    scope :pending, -> { where(done: false) }
end
