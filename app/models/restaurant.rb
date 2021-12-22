class Restaurant < ApplicationRecord
    has_many :pizzas
    validates :name, presence: true
    validates :city, presence: true
    validates :state, presence: true

    def self.alpha 
       Restaurant.all.order(:state)
    end 

end
