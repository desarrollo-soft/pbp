require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "User Model" do
  include UserSpecHelper

  before(:each) do
    @user = User.new
  end

  it 'can be created' do
    @user.should_not be_nil
  end

  it "should be invalid without a username" do
    @user.attributes = valid_user_attributes.except(:username)
    @user.should_not be_valid
  end

  it "should be invalid without an email" do
    @user.attributes = valid_user_attributes.except(:email)
    @user.should_not be_valid
  end

  it "should be invalid without a password" do
    @user.attributes = valid_user_attributes.except(:new_password)
    @user.save
    @user.should_not be_valid
  end

  it "should be invalid without a password confirmation" do
    @user.attributes = valid_user_attributes.except(:new_password_confirmation)
    @user.save
    @user.should_not be_valid
  end

  it "should be invalid without password and password confirmation" do
    @user.attributes = valid_user_attributes.except(:new_password).except(:new_password_confirmation)
    @user.save
    @user.should_not be_valid
  end
end
