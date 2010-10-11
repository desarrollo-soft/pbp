require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "CampaignInviteEmail Model" do
  let(:campaign_invite_email) { CampaignInviteEmail.new }
  it 'can be created' do
    campaign_invite_email.should_not be_nil
  end
end
