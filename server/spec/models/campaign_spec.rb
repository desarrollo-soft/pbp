require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "Campaign Model" do
  include UserSpecHelper

  before(:all) do
    @user = User.new
    @user.attributes = valid_user_attributes
    @user.save
  end

  after(:all) do
    @user.destroy
  end

  before(:each) do
    @campaign = Campaign.new
  end

  it 'can be created' do
    @campaign.should_not be_nil
  end

  it 'should have a name' do
    @campaign.should_not be_valid
  end
end
