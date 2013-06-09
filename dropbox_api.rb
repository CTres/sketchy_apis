require 'rubygems'
require 'mechanize'

class User
	attr_accessor :fname, :lname, :email, :password, :team_num_users, :team_name, :phone, :country
	def initialize(fname, lname, email, password, team_num_users, team_name, phone, country)
		@fname, @lname, @email, @password, @team_num_users, @team_name, @phone, @country = fname, lname, email, password, team_num_users, team_name, phone, country
	end
end


class CreditCard 
	attr_accessor :name, :number, :expmo, :expyr, :ccode, :address, :city, :state, :zip
	def initialize(name, number,expmo, expyr, ccode, address, city, state, zip)
		@name, @number, @expmo, @expyr, @ccode, @address, @city, @state, @zip = name, number, expmo, expyr, ccode, address, city, state, zip
	end
end

@chuck = User.new('charles', 'treseler', 'ctreseler@example.com', 'margaret', 12, 'rockstars', '6175640388', 'US')
@card = CreditCard.new('Colin Treseler',12123123321132,1,1,12,'manet','newton', 'ma', 123123)

def dropbox_new_consumer_account(user)
#create mechanize agent
agent= Mechanize.new{ |agent| agent.user_agent_alias = 'Mac Safari'}
agent.cookie_jar.clear!
page = agent.get('http://www.dropbox.com/')

#pull the signup form from the dropbox page
dropbox_form=page.forms[1]

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

def dropbox_new_business_account(user,card)
	agent = Mechanize.new
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
end

def dropbox_convert_to_business_accnt(user, card)
	#new business account from an existing consumer account
	agent = Mechanize.new
	agent.cookie_jar.clear!
	page = agent.get("https://www.dropbox.com/business/try")
	dropbox_form = page.forms[0]
	#company details
	dropbox_form.team_num_users = user.team_num_users
	dropbox_form.team_name = user.team_name
	dropbox_form.team_phone = user.phone

	#create new business account using existing account
	dropbox_form.login_email = user.email
	dropbox_form.login_password = user.password

	#add billing information
	dropbox_form.ccn = card.number
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
	pp page
end


#test call
convert_to_business_accnt(@chuck, @card)



