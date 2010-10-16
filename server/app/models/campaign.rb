class Campaign
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :master_user_id, Integer
  property :name, String

  validates_presence_of     :name
  validates_presence_of     :master_user_id

  has n, :character

  belongs_to :master_user , 'User', :key => true

  def initialize
    @validation = []
  end

  def inviteUser user
    if user == nil
      validation.push "Invalid user" #TODO: i18n
      return nil
    end

    invitation = CampaignInviteUser.new
    invitation.campaign_id = self[:id]
    invitation.user_id = user[:id]
    if invitation.save
      return invitation
    else
      invitation.errors.each do |e|
        e.each do |f|
          @validation = validation.push f
        end
      end
      return nil
    end
  end


  def inviteUsernameOrEmail username_or_email
    if username_or_email.include? "@"
      inviteEmail username_or_email
    else
      inviteUsername username_or_email
    end
  end

  def inviteEmail email
    if !email.match /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i #TODO: avoid duplicate regex
      validation.push "Invalid email format" #TODO: i18n
      return nil
    end

    user = User.first(:email => email)
    if user == nil
      invite = CampaignInviteEmail.new
      invite.campaign_id = self[:id]
      invite.email = email
      if invite.save
        #TODO: send some mail inviting him
        Pbp.deliver(:user_notifier, :invite, email, email)
        return invite
      else
        invite.errors.each do |e|
          e.each do |f|
            @validation = validation.push f
          end
        end
        return nil
      end
    else
      inviteUser user
    end
  end

  def inviteUsername username
    inviteUser User.first(:username => username)
  end

  def validation
    @validation ||= []
  end

  def post user, message
    return false
  end
end
