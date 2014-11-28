# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create name: 'First User'

user = User.first

user.lists.create name: 'Groceries'
user.lists.create name: 'Vacation'
user.lists.create name: 'Work'

list = User.first.lists.first

list.items.create content: 'Lettuce'
list.items.create content: 'Bread'
list.items.create content: 'Milk'
list.items.create content: 'Tomato'
list.items.create content: 'Grounf beef'