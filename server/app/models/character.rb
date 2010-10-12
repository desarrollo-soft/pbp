class Character
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :campaign_id, Integer
  property :user_id, Integer
  property :name, String
  property :bio, Text
  property :stats, Text

  belongs_to :campaign
  belongs_to :user

  validates_presence_of     :name
  validates_presence_of     :stats
  validates_uniqueness_of   :username,    :case_sensitive => false

  validates_with_method :unique_player_character_per_campaign

  def unique_player_character_per_campaign
    campaign = Campaign.get self.campaign_id
    return true if self.user_id == campaign.master_user_id
    return [false, "User not invited to campaign"] if CampaignInviteUser.count(:campaign_id => self.campaign_id, :user_id => self.user_id) == 0 #TODO: i18n
    if Character.count(:user_id => self.user_id, :campaign_id => self.campaign_id) == 0
      return true
    else
      return [false, "User already has a character for this campaign"] #TODO: i18n
    end
  end
end
