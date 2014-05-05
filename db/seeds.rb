# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Couleur.delete_all
User.delete_all
App.delete_all

User.create!(name: 'admin', password:'admin', admin: 'true')

App.create!(name: 'iAddic7')
App.create!(name: 'PPWordPressModel')
App.create!(name: 'DriveCity2')
App.create!(name: 'Humanoid')
App.create!(name: 'Bunny Maniacs')

