require './dropbox_api'
require './basecamp_api'

namespace :dropbox do
  desc 'Create a new Dropbox consumer account'
  task :consumer_account do
    email = create_email
    user = User.new({
      :fname => 'Charles',
      :lname => 'Treseler',
      :email => "#{email}@example.com",
      :password => 'password123'
    })

    Dropbox.consumer_account(user)
  end
end

namespace :basecamp do
  desc 'Create a new Basecamp account'
  task :new_account do
    email = create_email
    user = User.new({
      :fname => 'charles',
      :lname => 'treseler',
      :email => 'colin.treseler@klarna.com',
      :team_name => 'foo team',
      :password => 'password123'
    })

    Basecamp.new_account(user)
  end
end

# Helpers
def create_email
  (0...8).map{ (65+rand(26)).chr }.join
end
