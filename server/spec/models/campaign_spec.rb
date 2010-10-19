require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "Campaign Model" do
  include UserSpecHelper

  before(:all) do
    @user = User.new
    @user.attributes = valid_user_attributes
    @user.save
    @user2 = User.new
    @user2.attributes = valid_user2_attributes
    @user2.save
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
    @campaign.master_user = @user
    @campaign.should_not be_valid
  end

  it 'should have a gm' do
    @campaign.name = 'Some lame name'
    @campaign.should_not be_valid
  end

  it 'should create a valid campaign' do
    create_campaign
    @campaign.should be_valid
    destroy_campaign
  end

  it 'should not allow game master to invite his username' do
    create_campaign
    @campaign.inviteUsernameOrEmail(@user.username).should be nil
    destroy_campaign
  end

  it 'should not allow game master to invite his email' do
    create_campaign
    @campaign.inviteUsernameOrEmail(@user.email).should be nil
    destroy_campaign
  end

  it 'should not allow game master to invite a username that does not exists' do
    create_campaign
    @campaign.inviteUsernameOrEmail('invalid_username').should be nil
    destroy_campaign
  end

  it 'should allow game master to invite email not registered and send an email' do
    Pbp.stub!(:deliver).and_return(true)
    Pbp.should_receive(:deliver).with(:user_notifier, :invite, 'example5@example.com', 'example5@example.com').and_return(true)
    create_campaign
    @campaign.inviteUsernameOrEmail('example5@example.com')
    destroy_campaign
  end

  it 'should add any invites after signup sent to the email address'

  it 'should allow to invite usernames' do
    create_campaign
    @campaign.inviteUsernameOrEmail(@user2.username).should_not be nil
    destroy_campaign #TODO: leaving an invite with broken FK?
  end

  it 'should not allow to invite usernames already invited to the campaign' do
    create_campaign
    @campaign.inviteUsernameOrEmail(@user2.username).should_not be nil
    @campaign.inviteUsernameOrEmail(@user2.username).should be nil
    destroy_campaign
  end

  it 'should not allow to invite usernames already playing the campaign' do
    create_campaign
    invite = @campaign.inviteUsernameOrEmail(@user2.username)
    invite.should_not be nil

    character = Character.new
    character.campaign = @campaign
    character.user = @user2
    character.name = 'Killer'
    character.stats = 'Kill 10'
    character.save

    @campaign.inviteUsernameOrEmail(@user2.username).should be nil

    invite.destroy
    destroy_campaign
  end

  it 'should not allow to invite emails already invited to the campaign' do
    create_campaign
    @campaign.inviteUsernameOrEmail(@user2.username).should_not be nil
    @campaign.inviteUsernameOrEmail(@user2.email).should be nil
    destroy_campaign
  end

  it 'should not allow to invite emails already playing the campaign' do
    create_campaign
    invite = @campaign.inviteUsernameOrEmail(@user2.username)
    invite.should_not be nil

    character = Character.new
    character.campaign = @campaign
    character.user = @user2
    character.name = 'Killer'
    character.stats = 'Kill 10'
    character.save
    
    @campaign.inviteUsernameOrEmail(@user2.email).should be nil
    invite.destroy
    destroy_campaign
  end

  it 'should not include unknown users' do
    create_campaign
    @campaign.includeUser(@user2).should be false
    destroy_campaign
  end

  it 'should include game master' do
    create_campaign
    @campaign.includeUser(@user).should be true
    destroy_campaign
  end

  it 'should include invited users' do
    create_campaign
    invite = @campaign.inviteUsernameOrEmail(@user2.username)
    @campaign.includeUser(@user2).should be true
    invite.destroy
    destroy_campaign
  end

  it 'should include characters users' do
    create_campaign
    invite = @campaign.inviteUsernameOrEmail(@user2.username)
    invite.should_not be nil

    character = Character.new
    character.campaign = @campaign
    character.user = @user2
    character.name = 'Killer'
    character.stats = 'Kill 10'
    character.save

    invite.destroy

    @campaign.includeUser(@user2).should be true
    character.destroy
    destroy_campaign
  end

  def create_campaign
    @campaign.name = 'Some lame name'
    @campaign.master_user = @user
    @campaign.save
  end

  def destroy_campaign
    @campaign.destroy
  end
end
