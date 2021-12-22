class Pizza < ApplicationRecord
  belongs_to :user #Whoever created the pizza
  belongs_to :restaurant
  has_many :ratings
  has_many :users, through: :ratings #these are the users who have rated the pizza
  accepts_nested_attributes_for :restaurant #necessary if using a nested form 

  has_one_attached :image #this tells rails to look at active storage and see the attatchement 
  #has_many_attatched :images #use this only if adding on multiple images 

  validates :specialtyname, presence: true
  validates :toppings, presence: true

  #scopes 
  #order specialty name alphabetically 
  #test scope methods in console rails c
  #define these in the model - call them in the controller or view (
  def self.alpha 
    order(:specialtyname)
  end 

  #to find the highest rated pizza - join the two tables (pizza and rating) Pizza.joins(:ratings).group(:id).order('avg(rate) desc'))
  #put this in pizza controlelr
  scope :order_by_rating, -> {Pizza.joins(:ratings).group(:id).order('avg(rate) desc')}
  def not_a_duplicate #custom validation
    #query the db - if a pizza is already created with the same specialtyname and restaurant, thow an error
    #check this in rails c - Pizza.find_by(specialtryname: 'Mellow Mushroom', restaurant_id: 1)
    if Pizza.find_by(specialtyname: specialtyname, restaurant_id: restaurant_id)
        errors.add(:specialtyname, "This pizza is already created. Please add a new pizza.")
    end 
  end 

  def specialtyname_and_restaurant #this method is used to list multiple things within the collection select
    "#{specialtyname} - #{restaurant.name}"
  end 
  

  #validates :specialtyname, uniqueness: {scope: :restaurant, message: 'This pizza is already created.' }


  #--- add in the restaurant attributes - create a restaurant if the name is not empty - This is the logic that lets you save the dropdown 
  def restaurant_attributes=(attributes)
    self.restaurant = Restaurant.find_or_create_by(attributes) if 
      !attributes['name'].empty?
    self.restaurant
  end
end
