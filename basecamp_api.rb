require 'rubygems'
require 'mechanize'

class User
  attr_accessor :fname, :lname, :email, :password, :phone, :team_num_users, :team_name, :login_email, :login_password, :name, :ccn, :expmo, :expyr, :ccode, :address, :city, :state, :zip, :country_code

  def initialize(fname, lname, email, password, phone, team_num_users, team_name, login_email, login_password, name, ccn,expmo, expyr, ccode, address, city, state, zip, country_code)
  @fname, @lname, @email, @password, @phone, @team_num_users, @team_name,
  @name, @login_email, @login_password, @ccn, @expmo, @expyr, @ccode, @address, @city, @state, @zip, @country_code =
  fname, lname, email, password, phone, team_num_users, team_name, name, login_email,
  login_password, ccn, expmo, expyr, ccode, address, city, state, zip, country_code
  end
end



module Basecamp

  def self.new_account(user)
    agent = Mechanize.new{ |agent| agent.user_agent_alias = 'Mac Safari'}
    agent.cookie_jar.clear!
    page = agent.get('http://basecamp.com')
    basecamp_form = page.forms[0]
    agent.page.forms[0]["signup[full_name]"] = user.fname + ' ' + user.lname
    agent.page.forms[0]["signup[email_address]"] = user.email
    agent.page.forms[0]["signup[company_name]"] = user.team_name
    agent.page.forms[0]["signup[password]"] = user.password
    agent.page.forms[0]["signup[password_confirmation]"] = user.password
    page = agent.submit basecamp_form
    
    if page.title.include? "Thanks for choosing"
      puts "success"
    else
      raise "error, account not created"
    end
  end
end


chuck = User.new('colin', 'treseler', 'colin.treseler@klarna.se', 'foo1NecN;l', '6175640388', '10', 'extralas', '', '', 'colin treseler', '4556810589466228', '12', '14', '166', '79 manet rd', 'newton', 'ma', '02467', 'us')

Basecamp.new_account(chuck)