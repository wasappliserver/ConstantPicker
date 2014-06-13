class App < ActiveRecord::Base
  has_many :couleurs
  has_many :numbers
  has_many :at_strings
  has_many :localizables
  has_many :theme_colors
  has_and_belongs_to_many :users
end