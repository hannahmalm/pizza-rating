class Restaurant < ApplicationRecord
    has_many :pizzas
    validates :name, presence: true
    validates :city, presence: true
    validates :state, presence: true
end
