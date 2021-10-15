class Pizza < ApplicationRecord
  belongs_to :user #Whoever created the pizza
  belongs_to :restaurant
  has_many :ratings
  has_many :users, through: :ratings #these are the users who have rated the pizza
  accepts_nested_attributes_for :restaurant #necessary if using a nested form 

  validates :specialtyname, presence: true
  validates :toppings, presence: true

  validates not_a_duplicate #custom validation
    #query the db - if a pizza is already created with the same specialtyname and restaurant, thow an error
    #check this in rails c - Pizza.find_by(specialtryname: 'Mellow Mushroom', restaurant_id: 1)
    if Pizza.find_by(specialtyname: specialtyname, restaurant_id: restaurant_id)
        errors.add(:specialtyname, "This pizza is already created. Please add a new pizza.")
    end 
  end 

  #validates :specialtyname: uniqueness: {scope: :restaurant, message: 'This pizza is already created.' }


  #--- add in the restaurant attributes - create a restaurant if the name is not empty
  def restaurant_attributes(attributes)
    restaurant = Restaurant.find_or_create_by(attributes) if 
      !name.empty?
  end

  #the belongs_to resttaurant gives us a reader method for restaurant 
    #def resturant=
    #end 

    #def build_restuants 
    #end 

    #def resturant_id 
    #end 
end
