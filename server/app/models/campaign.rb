class Campaign
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :master_user_id, Integer
  property :name, String

  belongs_to :master_user , 'User', :key => true

  def inviteUser user
    invitation = CampaignInviteUser.new
    invitation.campaign_id = self[:id]
    invitation.user_id = user[:id]
    invitation.save
  end
end
