module Mimicry
  class Dropbox
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
      agent = Mechanize.new{|agent| agent.user_agent_alias = 'Mac Safari' }
      agent.cookie_jar.clear!
      form = agent.get('http://www.dropbox.com/').forms[1]

      CONSUMER_FIELDS.each do |field|
        field = field.to_sym
        form.send field, user[field]
      end

      form.checkbox_with(:name => 'tos_agree').check
      page = agent.submit(form)

      if page.title.include? 'Downloading Dropbox'
        puts 'success'
      else
        raise 'error, user not created'
      end
    end

    def self.business_account(user)
      agent = Mechanize.new{|agent| agent.user_agent_alias = 'Mac Safari' }
      agent.cookie_jar.clear!
      form = agent.get("https://www.dropbox.com/business/try").forms[0]

      NEW_BUSINESS_FIELDS.each do |field|
        field = field.to_sym
        form.send field, user[field]
      end

      #iterator cannot handle checkbox condition, and where form field name = 'name'
      form.field_with(:name => 'name').value = "#{user[:fname]} #{user[:lname]}"
      form.checkbox_with(:name => 'tos_agree').check
      page = agent.submit form

      #still requiring confirmation page validation
    end

    def self.convert_to_business_account(user)
      #new business account from an existing consumer account
      agent = Mechanize.new{|agent| agent.user_agent_alias = 'Mac Safari' }
      agent.cookie_jar.clear!
      form = agent.get("https://www.dropbox.com/business/try").forms[0]

      CONVERT_BUSINESS_FIELDS.each do |field|
        field = field.to_sym
        form.send field, user[field]
      end

      #handling exceptions that don't work in the iterator
      form.field_with(:name => 'name').value = "#{user[:fname]} #{user[:lname]}"
      form.checkbox_with(:name => 'tos_agree').check
      page = agent.submit form

      #still need to validate at confirmation page
    end
  end
end
