# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.create!(:name=>"飲食")
Category.create!(:name=>"訓練")
Category.create!(:name=>"器材")
Category.create!(:name=>"增肌")
Category.create!(:name=>"減脂")
Category.create!(:name=>"雕塑")
Category.create!(:name=>"其他")
Tag.create!(:name=>"低卡料理")
Tag.create!(:name=>"腹肌")
Tag.create!(:name=>"TABATA")
Tag.create!(:name=>"減重料理")
Tag.create!(:name=>"七分鐘運動")
