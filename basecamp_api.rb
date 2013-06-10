require 'rubygems'
require 'mechanize'
require './userAndMember.rb'




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

  def self.login(user)
    #only works for an email with a single associated account
    agent = Mechanize.new{ |agent| agent.user_agent_alias = 'Mac Safari'}
    agent.cookie_jar.clear!
    basecamp_form = agent.get('https://launchpad.37signals.com/basecamp/signin').forms[0]
    basecamp_form.username = user.email
    basecamp_form.password = user.password
    page = basecamp_form.click_button
    page.uri
  end

  def self.add_member(user, member)
    agent = Mechanize.new{ |agent| agent.user_agent_alias = 'Mac Safari'}
    agent.cookie_jar.clear!
    basecamp_form = agent.get('https://launchpad.37signals.com/basecamp/signin').forms[0]
    basecamp_form.username = user.email
    basecamp_form.password = user.password
    page = basecamp_form.click_button
    url = page.uri
    page = agent.get("#{url}people/new")
    pp page
  end
end




