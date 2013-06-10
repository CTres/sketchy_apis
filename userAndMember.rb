
class User
  ATTRIBUTES = [
  :fname, :lname, :email, :password, :team_phone, :team_num_users,
  :team_name, :login_email, :login_password, :name, :ccn, :expmo,
  :expyr, :ccode, :address, :city, :state, :zip, :country_code
  ]
 
  attr_accessor *ATTRIBUTES
 
  def initialize(attributes = {})
    attributes.each_pair do |k, v|
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

class Member
  ATTRIBUTES = [:fname, :lname, :email_address]

  attr_accessor *ATTRIBUTES
  
  def initialize(attributes = {})
    attributes.each_pair do |k, v|
      send("#{k}=", v)
    end
  end
  def to_hash()
    hash = {}
    instance_variables.each do |ivar|
      hash[ivar.to_s.delete("@")] = instance_variable_get(ivar)
    end
    hash
  end
end