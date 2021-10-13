class User < ApplicationRecord
    has_many :ratings
    has_many :pizzas, through: :ratings
end
