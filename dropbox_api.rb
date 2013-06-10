require 'rubygems'
require 'mechanize'
 
module Dropbox
  CONSUMER_FIELDS = %w(fname lname email password)
  NEW_BUSINESS_FIELDS = %w(
    team_num_users team_name team_phone fname lname email password
    ccn expmo expyr ccode address city state zip country_code
  )
  CONVERT_BUSINESS_FIELDS = %w(
    team_num_users team_name team_phone login_email login_password
    ccn expmo expyr ccode address city state zip country_code
  )

  def self.consumer_account(user)
    user = user.to_hash
    agent = Mechanize.new{|agent| agent.user_agent_alias = 'Mac Safari' }
    agent.cookie_jar.clear!
    dropbox_form = agent.get('http://www.dropbox.com/').forms[1]
    pp dropbox_form
    CONSUMER_FIELDS.each do |field|
      dropbox_form.send field.to_sym, user[field]
    end

    dropbox_form.checkbox_with(:name => 'tos_agree').check
    page = agent.submit(dropbox_form)

    if page.title.include? 'Downloading Dropbox'
      puts 'success'
    else
      raise 'error, user not created'
    end
  end

  def self.business_account(user)
    user = user.to_hash
    agent = Mechanize.new{ |agent| agent.user_agent_alias = 'Mac Safari'}
    agent.cookie_jar.clear!
    dropbox_form = agent.get("https://www.dropbox.com/business/try").forms[0]

    NEW_BUSINESS_FIELDS.each do |field|
      dropbox_form.send field.to_sym, user[field]
    end

    #iterator cannot handle checkbox condition, and where form field name = 'name'
    dropbox_form.field_with(:name => 'name').value = "#{user.fname} #{user.lname}"
    dropbox_form.checkbox_with(:name => 'tos_agree').check
    page = agent.submit dropbox_form

    #still requiring confirmation page validation
  end

  def self.convert_to_business_account(user)
    user = user.to_hash
    #new business account from an existing consumer account
    agent = Mechanize.new{|agent| agent.user_agent_alias = 'Mac Safari' }
    agent.cookie_jar.clear!
    dropbox_form = agent.get("https://www.dropbox.com/business/try").forms[0]

    CONVERT_BUSINESS_FIELDS.each do |field|
      dropbox_form.send field.to_sym, user[field]
    end

    #handling exceptions that don't work in the iterator
    dropbox_form.field_with(:name => 'name').value = "#{user.fname} #{user.lname}"
    dropbox_form.checkbox_with(:name => 'tos_agree').check
    page = agent.submit dropbox_form

    #still need to validate at confirmation page
  end
end
