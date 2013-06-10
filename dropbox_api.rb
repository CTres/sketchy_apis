require 'rubygems'
require 'mechanize'

class User
  ATTRIBUTES = [
  :fname, :lname, :email, :password, :team_phone, :team_num_users,
  :team_name, :login_email, :login_password, :name, :ccn, :expmo,
  :expyr, :ccode, :address, :city, :state, :zip, :country_code
  ]
 
  attr_accessor *ATTRIBUTES
 
  def initialize(attributes = {})
    attributes.each_pair do |k, v|
      #setter method
      send("#{k}=", v)


    end
  end
 
  def to_hash
  #create a hash of the instance variables
    hash = {}
    instance_variables.each do |ivar|
      hash[ivar.to_s.delete("@")] = instance_variable_get(ivar)
    end
 
    hash
    end
  end
 
module Dropbox
  CONSUMER_FIELDS = %w(fname lname email password)

  NEW_BUSINESS_FIELDS = %w(team_num_users team_name team_phone fname lname email password ccn expmo expyr ccode address city state zip country_code)
  
  CONVERT_BUSINESS_FIELDS = %w
  def self.consumer_account(user)
    user = user.to_hash
    agent = Mechanize.new{|agent| agent.user_agent_alias = 'Mac Safari' }
    agent.cookie_jar.clear!
    dropbox_form = agent.get('http://www.dropbox.com/').forms[1]
   
    CONSUMER_FIELDS.each do |field|
      dropbox_form.send(field.to_sym, user[field])
    end

    dropbox_form.checkbox_with(:name => 'tos_agree').check
    page = agent.submit dropbox_form
   
    if page.title.include? "Downloading Dropbox"
      puts "success"
    else
      raise "error, user not created"
    end
  end

   
  chuck = User.new({
  :fname => 'charles',
  :lname => 'treseler',
  :email => 'colin.treseler@klarna.com',
  :password => 'password123',
  :team_phone => '6175640388',
  :team_num_users => '10',
  :team_name => 'extrala',
  :login_email => '',
  :login_password => '',
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
   
  def self.new_business_account(user)
    
    user = user.to_hash
    agent = Mechanize.new{ |agent| agent.user_agent_alias = 'Mac Safari'}
    agent.cookie_jar.clear!
    dropbox_form = agent.get("https://www.dropbox.com/business/try").forms[0]
    NEW_BUSINESS_FIELDS.each do |field|
      dropbox_form.send(field.to_sym, user[field])
    end
    
    #iterator cannot handle checkbox condition, and where form field name = 'name'  
    dropbox_form.checkbox_with(:name => 'tos_agree').check
    dropbox_form.field_with(:name => 'name').value = "#{user['fname']}" + ' ' + "#{user['lname']}"
    page = agent.submit dropbox_form

    #still requiring confirmation page validation
  end

Dropbox.new_business_account(chuck)


  def self.convert_to_business_account(user)
    #new business account from an existing consumer account
    agent = Mechanize.new{|agent| agent.user_agent_alias = 'Mac Safari' }
    agent.cookie_jar.clear!
    dropbox_form = agent.get("https://www.dropbox.com/business/try").forms[0]

    dropbox_form.send field.to_sym, user[field]
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
      dropbox_form__send__(attributes.to_sym, user[attributes])
    end
  
  dropbox_form.checkbox_with(:name => 'tos_agree').check
  pp page
  end


end





