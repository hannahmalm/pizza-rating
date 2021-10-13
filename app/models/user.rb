class User < ApplicationRecord
    has_many :ratings
    has_many :rated_pizzas, through: :ratings, source: :pizza
    has_many :pizzas #pizzas that the user creates within the application

    has_secure_password
end
