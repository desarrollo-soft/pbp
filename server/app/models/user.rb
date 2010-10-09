require 'digest/sha1'

class User
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :username, String
  property :password, String
  property :email, String

  def self.authenticate(username, password)
    hashed_password = Digest::SHA1.hexdigest(password)
    account = first(:conditions => { :username => username }) if username.present?
    account && account.password == hashed_password ? account : nil
  end

  def setPassword(_password)
    self.password = Digest::SHA1.hexdigest(_password)
  end
end
