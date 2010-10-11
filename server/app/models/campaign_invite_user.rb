class CampaignInviteUser
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :campaign_id, Integer
  property :user_id, Integer

  validates_with_method :user_in_campaign

  def user_in_campaign
    #TODO add accepted invitations
    CampaignInviteUser.count(:campaign_id => self.campaign_id, :user_id => self.user_id) +
    Campaign.count(:id => self.campaign_id, :master_user_id => self.user_id) == 0
  end
end
