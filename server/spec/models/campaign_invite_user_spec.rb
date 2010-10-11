require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "CampaignInviteUser Model" do
  let(:campaign_invite_user) { CampaignInviteUser.new }
  it 'can be created' do
    campaign_invite_user.should_not be_nil
  end
end
