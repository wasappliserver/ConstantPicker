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

User.create!(name: 'admin', password: 'wasappliserver', admin: 'true')
User.create!(name: 'client1', password: 'client1', admin: 'false')
User.create!(name: 'client2', password: 'client2', admin: 'false')

App.create!(name: 'iAddic7', app_token: 'ebf9cd8b5449e757455ac02e9344e3c0')
App.create!(name: 'PPWordPressModel', app_token: 'f18b977942330d0399d2cf14ebc81d37')
App.create!(name: 'DriveCity2', app_token: 'e3038e6d3ee4b8db5e1320619e4c1575')
App.create!(name: 'Humanoid', app_token: 'edf8b064c096691e539b7e2a3e28179d')
App.create!(name: 'Bunny Maniacs', app_token: 'b6f209264f0454e049716d7681b4350e')



