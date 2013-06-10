require './dropbox_api'
require './basecamp_api.rb'

chuck = User.new({
  :fname => 'col',
  :lname => 'tres',
  :email => 'colin@example.com',
  :password => 'margaret',
  :team_phone => '6175640388',
  :team_num_users => '10',
  :team_name => 'extrala',
  :login_email => 'colin@example.com',
  :login_password => 'margaret',
  :name => 'colin treseler',
  :ccn => '4556810589466228',
  :ccode => '166',
  :expmo => '12',
  :expyr => '14',
  :address => '79 manet rd',
  :city => 'newton',
  :state => 'ma',
  :zip => '02467',
  :country_code => 'us'
  })

colin = Member.new({
:fname => 'colin',
:lname => 'treseler',
:email_address => 'colin@example.com'
})

#Dropbox.consumer_account(chuck)

#Basecamp.add_member(chuck, colin)
#finding an error where the form[number] is changing.
#Basecamp.new_account(chuck)
#Basecamp.login(chuck)
Basecamp.add_member(chuck,colin)