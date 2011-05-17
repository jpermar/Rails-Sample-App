namespace :db do
  desc  "Create an admin user"
  task :create_admin => :environment do
    admin = User.create!(:name => "Poo Bear",
                 :email => "poobear@example.com",
                 :password => "poobear",
                 :password_confirmation => "poobear")
    admin.toggle!(:admin)
  end    
end
