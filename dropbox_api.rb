require 'rubygems'
require 'mechanize'

class CreditCard 
  attr_accessor :ccn, :expmo, :expyr, :ccode, :address, :city, :state, :zip, :country_code
  def initialize(ccn,expmo, expyr, ccode, address, city, state, zip, country_code)
  @ccn, @expmo, @expyr, @ccode, @address, @city, @state, @zip, @country_code = ccn, expmo, expyr, ccode, address, city, state, zip, country_code
  end
end

class User
  attr_accessor :fname, :lname, :email, :password, :phone, :team_num_users, :team_name, :login_email, :login_password, :name, :ccn, :expmo, :expyr, :ccode, :address, :city, :state, :zip, :country_code

  def initialize(fname, lname, email, password, team_num_users, team_name, phone, login_email, login_password, name, ccn,expmo, expyr, ccode, address, city, state, zip, country_code)
  @fname, @lname, @email, @password, @phone, @team_num_users, @team_name,
  @name, @login_email, @login_password, @ccn, @expmo, @expyr, @ccode, @address, @city, @state, @zip, @country_code =

  fname, lname, email, password, phone, team_num_users, team_name, name, login_email,
  login_password, ccn, expmo, expyr, ccode, address, city, state, zip, country_code
  end
end

module Dropbox


  



  def self.new_consumer_account(user)
    #create mechanize agent
    agent = Mechanize.new{ |agent| agent.user_agent_alias = 'Mac Safari'}
    agent.cookie_jar.clear!
    page = agent.get('http://www.dropbox.com/')

    #pull the signup form from the dropbox page
    dropbox_form = page.forms[1]

    #set values in form fields
    dropbox_form.fname = user.fname
    dropbox_form.lname = user.lname
    dropbox_form.email = user.email
    dropbox_form.password = user.password
    dropbox_form.checkbox_with(:name => 'tos_agree').check
    page = agent.submit dropbox_form

    #toss an exception if the user cannot be created.
    if page.title.include? "Downloading Dropbox"
      puts "success"
    else
      raise "error, user not created"
    end
  end

  def self.new_business_account(user,card)
    agent = Mechanize.new{ |agent| agent.user_agent_alias = 'Mac Safari'}
    agent.cookie_jar.clear!
    page = agent.get("https://www.dropbox.com/business/try")
    dropbox_form = page.forms[0]
    #company details
    dropbox_form.team_num_users = user.team_num_users
    dropbox_form.team_name = user.team_name
    dropbox_form.team_phone = user.phone

    #create new admin account
    dropbox_form.fname = user.fname
    dropbox_form.lname = user.lname
    dropbox_form.email = user.email
    dropbox_form.password = user.password

    #add billing information
    dropbox_form.ccn = card.number
    dropbox_form.name = card.name
    dropbox_form.expmo = card.expmo
    dropbox_form.expyr = card.expyr
    dropbox_form.ccode = card.ccode
    dropbox_form.address = card.address
    dropbox_form.city = card.city
    dropbox_form.state = card.state
    dropbox_form.zip = card.zip
    dropbox_form.country_code = user.country
    #see if the country code works like this 
    dropbox_form.checkbox_with(:name => 'tos_agree').check
    page = agent.submit dropbox_form
  end

  def self.convert_to_business_account(user, card)
    #new business account from an existing consumer account
    agent = Mechanize.new{|agent| agent.user_agent_alias = 'Mac Safari' }
    agent.cookie_jar.clear!
    page = agent.get("https://www.dropbox.com/business/try")
    pp page


    dropbox_form = page.forms[0]
    #company details
    dropbox_form.team_num_users = user.team_num_users
    dropbox_form.team_name = user.team_name
    dropbox_form.team_phone = user.phone

    #create new business account using existing account
    dropbox_form.login_email = user.email
    dropbox_form.login_password = user.password

    #add billing information
    dropbox_form.ccn = card.ccn
    dropbox_form.name = user.fname + ' ' + user.lname
    dropbox_form.expmo = card.expmo
    dropbox_form.expyr = card.expyr
    dropbox_form.ccode = card.ccode
    dropbox_form.address = card.address
    dropbox_form.city = card.city
    dropbox_form.state = card.state
    dropbox_form.zip = card.zip
    dropbox_form.country_code = user.country
    dropbox_form.checkbox_with(:name => 'tos_agree').check
    page = agent.submit dropbox_form

  end

  def self.consumer_account(user)


    fields = ['fname','lname', 'email', 'password', 'phone', 'team_num_users',
 'team_name', 'login_email', 'login_password', 'name', 'ccn', 'expmo', 'expyr', 'ccode', 'address', 'city', 'state', 'zip', 'country_code']


    agent = Mechanize.new{|agent| agent.user_agent_alias = 'Mac Safari' }
    agent.cookie_jar.clear!
    page = agent.get('http://www.dropbox.com/')
    dropbox_form = page.forms[1]
    
    fields.each do |attributes|
      dropbox_form[attributes] = user[attributes]
    end
  
  dropbox_form.checkbox_with(:name => 'tos_agree').check
  pp page
  end


end

chuck = User.new('charles', 'treseler', 'colin.treseler@klarna.com', 'password123', '6175640388', '10', 'extrala', '', '', 'colin treseler', '4556810589466228', '12', '14', '166', '79 manet rd', 'newton', 'ma', '02467', 'us')
Dropbox.consumer_account(chuck)
#Dropbox.consumer_account(chuck)





