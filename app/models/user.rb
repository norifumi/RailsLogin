class User < ApplicationRecord
  ACCESS_TOKEN_SALT = "088707c95b335a97"

  def id_access_token
    "#{id}:#{access_token}"
  end
 
  def valid_access_token? specimen
    specimen == access_token
  end
 
  class << self
    def find_by_id_access_token id_access_token
      user = User.find_by id: id_access_token.split(':')[0]
      return nil unless user
      return nil unless user.valid_access_token?(id_access_token.split(':')[1])
      return user
    end
  end
 
  private
 
  def access_token
    "#{Digest::MD5.hexdigest(password + ACCESS_TOKEN_SALT)}"
  end 

end
