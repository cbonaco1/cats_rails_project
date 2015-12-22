# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Cat.destroy_all

sennacy = Cat.create!(
  birth_date: "2015/12/22",
  color: "Brown",
  name: "Sennacy",
  sex: "M",
  description: "I'm the first cat!"
)

garfield = Cat.create!(
  birth_date: "2015/12/12",
  color: "Orange",
  name: "Garfield",
  sex: "M"
)

breakfast = Cat.create!(
  birth_date: "2015/02/22",
  color: "White",
  name: "Breakfast",
  sex: "F",
  description: "I love mornings!"
)

felix = Cat.create!(
  birth_date: "1970/12/22",
  color: "Black",
  name: "Felix",
  sex: "M",
  description: "I love cartoons!!"
)





CatRentalRequest.destroy_all

now = CatRentalRequest.create!(
  cat_id: 1,
  start_date: "2015/12/22",
  end_date: "2015/12/24"
)

yesterday = CatRentalRequest.create!(
  cat_id: 1,
  start_date: "2015/12/21",
  end_date: "2015/12/23"
)

next_week1 = CatRentalRequest.create!(
  cat_id: 2,
  start_date: "2015/12/30",
  end_date: "2015/12/31"
)

next_week2 = CatRentalRequest.create!(
  cat_id: 2,
  start_date: "2015/12/27",
  end_date: "2015/12/29"
)
