# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Couleur.delete_all
Couleur.create!(title: "COLOR_COMMENT_TEXT", coul_type: "UI_COLOR", value_coul:"0x4b4b4b")
Couleur.create!(title: "COLOR_CONTENT_TEXT", coul_type: "UI_COLOR", value_coul:"0x4b4baa")