class Rating < ApplicationRecord
  require 'uri'
  belongs_to :user
  belongs_to :pizza

  validates :title, presence: true
  validates :rate, numericality: { greater_than: 0, less_than: 10} #rate needs to be between 0 and 10
  validates :comment, presence: true
  #validate that if the pizza id has already been added, uniqueness scope is on the user id
  validates :pizza, uniqueness: {scope: :user, message: 'You have already rated this Pizza' }
end
