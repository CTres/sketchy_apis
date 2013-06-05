require 'rubygems'
require 'mechanize'

class User
	#needs validation of the user
	attr_accessor :fname, :lname, :email, :password
	
	def initialize(fname, lname, email, password)
	@fname, @lname, @email, @password = fname, lname, email, password
	end
end

def dropbox_new_consumer_accnt(user)
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
		else
			raise "error, user not created"

		end
	end






chuck = User.new('caz','zod','caszod@gmail.com','numnuts1234')
dropbox_new_consumer_accnt(chuck)










def new_b_accnt()

end

def existing_c_accnt()
end

def existing_b_accnt()

end

def convert_to_business

end




=begin 

useful but no longer relevant code 

pp dropbox_form.keys
agent.page.forms[0]

=end





