class Campaign
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :master_user_id, Integer
  property :name, String

  belongs_to :master_user , 'User', :key => true

  def inviteUser user
    if user == nil
      return
    end
    invitation = CampaignInviteUser.new
    invitation.campaign_id = self[:id]
    invitation.user_id = user[:id]
    invitation.save
  end


  def inviteUsernameOrEmail username_or_email
    if username_or_email.include? "@"
      inviteEmail username_or_email
    else
      inviteUsername username_or_email
    end
  end

  def inviteEmail email
    #TODO: validate email
    user = User.first(:email => email)
    if user == nil
      #TODO: send some mail inviting him
    else
      inviteUser user
    end
  end

  def inviteUsername username
    inviteUser User.first(:username => username)
  end
end
