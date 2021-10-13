class Pizza < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant
  has_many :ratings
  has_many :users, through: :ratings
end
