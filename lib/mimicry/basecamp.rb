module Mimicry
  class Basecamp
    def self.new_account(user = {})
      agent = Mechanize.new{|agent| agent.user_agent_alias = 'Mac Safari' }
      agent.cookie_jar.clear!
      page = agent.get('http://basecamp.com')
      form = page.forms[0]

      form["signup[full_name]"] = "#{user[:fname]} #{user[:lname]}"
      form["signup[email_address]"] = user[:email]
      form["signup[company_name]"] = user[:team_name]
      form["signup[password]"] = user[:password]
      form["signup[password_confirmation]"] = user[:password]

      page = agent.submit(form)

      if page.title.include? 'Thanks for choosing'
        puts 'success'
      else
        raise 'error, account not created'
      end
    end

    def self.login(user)
      #only works for an email with a single associated account
      agent = Mechanize.new{|agent| agent.user_agent_alias = 'Mac Safari' }
      agent.cookie_jar.clear!
      basecamp_form = agent.get('https://launchpad.37signals.com/basecamp/signin').forms[0]
      basecamp_form.username = user.email
      basecamp_form.password = user.password
      page = basecamp_form.click_button

      page.uri
    end

    def self.add_member(user, member)
      agent = Mechanize.new{|agent| agent.user_agent_alias = 'Mac Safari' }
      agent.cookie_jar.clear!
      form = agent.get('https://launchpad.37signals.com/basecamp/signin').forms[0]

      basecamp_form.username = user[:email]
      basecamp_form.password = user[:password]

      page = basecamp_form.click_button
      url = page.uri
      page = agent.get("#{url}people/new")

      pp page
    end
  end
end

