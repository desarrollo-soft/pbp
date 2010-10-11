class Campaign
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :master_user_id, Integer
  property :name, String

  belongs_to :master_user , 'User', :key => true

  def initialize
    @errors = []
  end

  def inviteUser user
    if user == nil
      errors.push "Invalid user" #TODO: i18n
      return false
    end
    invitation = CampaignInviteUser.new
    invitation.campaign_id = self[:id]
    invitation.user_id = user[:id]
    if invitation.save
      return true
    else
      invitation.errors.each do |e|
        e.each do |f|
          @errors = errors.push f
        end
      end
      return false
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
    #TODO: validate email
    if !email.match /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i #TODO: avoid duplicate regex
      errors.push "Invalid email format" #TODO: i18n
      return false;
    end

    user = User.first(:email => email)
    if user == nil
      #TODO: send some mail inviting him
      return true
    else
      inviteUser user
    end
  end

  def inviteUsername username
    inviteUser User.first(:username => username)
  end

  def errors
    @errors ||= []
  end
end
