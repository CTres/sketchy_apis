require './dropbox_api'

chuck = User.new({
  :fname => 'charles',
  :lname => 'treseler',
  :email => 'colin.treseler@klarna.com',
  :password => 'password123',
  :team_phone => '6175640388',
  :team_num_users => '10',
  :team_name => 'extrala',
  :login_email => 'colin.treseler@klarna.com',
  :login_password => 'foo1NecN;l',
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


Dropbox.consumer_account(chuck)
