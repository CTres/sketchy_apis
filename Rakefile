require './lib/mimicry'
require './lib/mimicry/dropbox'
require './lib/mimicry/basecamp'

namespace :dropbox do
  desc 'Create a new Dropbox consumer account'
  task :consumer_account do
    email = create_email
    user = {
      :fname => 'Charles',
      :lname => 'Treseler',
      :email => "#{email}@example.com",
      :password => 'password123'
    }

    Mimicry::Dropbox.consumer_account(user)
  end
end

namespace :basecamp do
  desc 'Create a new Basecamp account'
  task :new_account do
    email = create_email
    user = {
      :fname => 'charles',
      :lname => 'treseler',
      :email => "#{email}@example.com",
      :team_name => 'foo team',
      :password => 'password123'
    }

    Mimicry::Basecamp.new_account(user)
  end
end

# Helpers
def create_email
  (0...8).map{ (65+rand(26)).chr }.join
end
