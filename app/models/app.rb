class App < ActiveRecord::Base
  has_many :couleurs
  has_many :numbers
  has_many :strings
  has_and_belongs_to_many :users
end