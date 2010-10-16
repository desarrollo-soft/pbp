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
end
