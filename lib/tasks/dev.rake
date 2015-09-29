namespace :dev do


  task :rebuild =>["db:drop", "db:setup", :faker]

  task :faker => :environment do
    User.delete_all
    Topic.delete_all
    Comment.delete_all

    puts "產生假資料"
    User.create(user_name:"Leon",email:"mgleon08@gmail.com",password:"12345678")
    User.create(user_name:"Test",email:"test@gmail.com",password:"12345678")
    10.times do |i|
      e = Topic.create(:name => Faker::App.name)
      10.times do|j|
        e.comments.create(:name => Faker::App.name)
      end
    end
  end
end