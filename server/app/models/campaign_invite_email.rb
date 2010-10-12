class CampaignInviteEmail
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :campaign_id, Integer
  property :email, String

  validates_with_method :email_in_campaign

  def email_in_campaign
    if CampaignInviteEmail.count(:campaign_id => self.campaign_id, :email => self.email) > 0
      return [ false, "Email already invited" ] #TODO: i18n
    end

    return true
  end
end
