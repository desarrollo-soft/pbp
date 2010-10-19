PADRINO_ENV = 'test' unless defined?(PADRINO_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

Spec::Runner.configure do |conf|
  conf.include Rack::Test::Methods
end

def app
  ##
  # You can handle all padrino applications using instead:
  #   Padrino.application
  Pbp.tap { |app|  }
end

module UserSpecHelper
  def valid_user_attributes
    {
      :email => "example@example.com",
      :username => "test",
      :new_password => "12345678",
      :new_password_confirmation => "12345678"
    }
  end

  def valid_user2_attributes
    {
      :email => "example2@example.com",
      :username => "test2",
      :new_password => "123456789",
      :new_password_confirmation => "123456789"
    }
  end

  def valid_user3_attributes
    {
      :email => "example3@example.com",
      :username => "test3",
      :new_password => "1234567890",
      :new_password_confirmation => "1234567890"
    }
  end
end
