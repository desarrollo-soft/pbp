require File.expand_path(File.dirname(__FILE__) + '/../spec_helper.rb')

describe "Campaign Model" do
  let(:campaign) { Campaign.new }
  it 'can be created' do
    campaign.should_not be_nil
  end
end
