class User < ActiveRecord::Base
    has_many :lists, -> { order "id DESC" }
    has_many :items, :through => :list
end
