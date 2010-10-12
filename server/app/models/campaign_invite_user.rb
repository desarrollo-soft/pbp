class CampaignInviteUser
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :campaign_id, Integer
  property :user_id, Integer

  belongs_to :user
  belongs_to :campaign

  validates_with_method :user_in_campaign

  def user_in_campaign
    if CampaignInviteUser.count(:campaign_id => self.campaign_id, :user_id => self.user_id) > 0
      return [ false, "User already invited" ] #TODO: i18n
    end

    if Campaign.count(:id => self.campaign_id, :master_user_id => self.user_id) > 0
      return [ false, "User is already playing" ] #TODO: i18n
    end

    if Character.count(:user_id => self.user_id, :campaign_id => self.campaign_id) > 0
      return [false, "User is already playing" ] #TODO: i18n
    end

    return true
  end

  def reject
    self.destroy
  end
end
