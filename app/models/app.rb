class App < ActiveRecord::Base
  belongs_to :couleurs
  has_and_belongs_to_many :users
end
