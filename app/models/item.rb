class Item < ActiveRecord::Base
    belongs_to :list

    scope :pending, -> { where(done: false) }
end
