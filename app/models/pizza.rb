class Pizza < ApplicationRecord
  belongs_to :user #Whoever created the pizza
  belongs_to :restaurant
  has_many :ratings
  has_many :users, through: :ratings #these are the users who have rated the pizza
  accepts_nested_attributes_for :restaurant 

  #the belongs_to resttaurant gives us a reader method for restaurant 
    #def resturant=
    #end 

    #def build_restuants 
    #end 

    #def resturant_id 
    #end 
end
