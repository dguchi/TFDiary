namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    10.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password  = "password"
      user = User.new(name: name, email: email, password: password)
      user.skip_confirmation!
      user.save!
    end
  end
end