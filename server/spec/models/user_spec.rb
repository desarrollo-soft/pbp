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

  it "should not allow usernames with '@'" do
    @user.attributes = valid_user_attributes.except(:new_password_confirmation)
    @user.username = @user.email
    @user.should_not be_valid
  end

  it "should allow valid user to sign up" do
    @user.attributes = valid_user_attributes
    @user.should be_valid
  end

  it "should not allow duplicated emails" do
    @user.attributes = valid_user_attributes
    @user.save
    user2 = User.new
    user2.attributes = valid_user_attributes.except(:email)
    user2.email = 'example2@example.com'
    user2.should_not be_valid
    @user.destroy
  end

  it "should not allow duplicated usernames" do
    @user.attributes = valid_user_attributes
    @user.save
    user2 = User.new
    user2.attributes = valid_user_attributes.except(:username)
    user2.username = 'test2'
    user2.should_not be_valid
    @user.destroy
  end

  it "should allowed registered user to signin" do
    @user.attributes = valid_user_attributes
    @user.save
    user = User.authenticate(valid_user_attributes[:username], valid_user_attributes[:new_password])
    user.should be_valid
    @user.destroy
  end

  it "should not allowed registered user to signin with wrong password" do
    @user.attributes = valid_user_attributes
    @user.save
    user = User.authenticate(valid_user_attributes[:username], '_fake_password_')
    user.should be nil
    @user.destroy
  end

  it "should add pending invites on signup"
end
