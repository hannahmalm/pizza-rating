class Rating < ApplicationRecord
  belongs_to :user
  belongs_to :pizza

  validates :title, presence: true
  validates :rate, numericality: { greater_than: 0}
  validates :comment, presence: true

  #validate that if the pizza id has already been added, uniqueness scope is on the user id
  validates :pizza, uniqueness: {scope: :user, message: 'You have already rated this' }

  # def self.order 
  #   Rating.order(:rating :desc)
  # end 
  
end
