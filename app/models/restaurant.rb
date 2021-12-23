class Restaurant < ApplicationRecord
    has_many :pizzas
    validates :name, presence: true
    validates :city, presence: true
    validates :state, presence: true
    scope :state_order, -> { Restaurant.all.order(:state)}

end
