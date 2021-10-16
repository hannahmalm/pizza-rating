class User < ApplicationRecord
    has_many :ratings
    has_many :rated_pizzas, through: :ratings, source: :pizza
    has_many :pizzas #pizzas that the user creates within the application
    has_secure_password #has validations built in for password - must enable bcrypt gem

    validates :username, uniqueness: true, presence: true 


    #will be called on user class
    def self.find_or_create_by_google(auth)
        User.find_or_create_by(username: auth[:info][:email]) do |u|
            u.password = SecureRandom.hex #set a random password when using omniauth and SecureRandom.hex
        end 
    end 

    def self.find_or_create_by_github(auth)
        User.find_or_create_by(username: auth[:info][:email]) do |u|
            u.password = SecureRandom.hex #set a random password when using omniauth and SecureRandom.hex
        end 
    end 

end
