class Pizza < ApplicationRecord
  belongs_to :user #Whoever created the pizza
  belongs_to :restaurant
  has_many :ratings
  has_many :users, through: :ratings #these are the users who have rated the pizza
  accepts_nested_attributes_for :restaurant #necessary if using a nested form 
  validates :specialtyname, presence: true
  validates :toppings, presence: true

  #scopes 
  #to find the highest rated pizza - join the two tables (pizza and rating) Pizza.joins(:ratings).group(:id).order('avg(rate) desc'))
  scope :highest_avg_rating_order, -> {Pizza.joins(:ratings).group(:id).order('avg(rate) desc')}
  #scope :most_popular_pizza, -> {Pizza.joins(:ratings).group(:id).order('avg(rate) desc').first} --> Find this within controller


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
  
  #--- add in the restaurant attributes - create a restaurant if the name is not empty - This is the logic that lets you save the dropdown 
  #https://medium.com/@ryanwerner_57863/how-to-build-a-nested-form-in-rails-using-fields-for-c185210f6869
  def restaurant_attributes=(attributes)
    self.restaurant = Restaurant.find_or_create_by(attributes) if 
      !attributes['name'].empty?
    self.restaurant
  end

end
