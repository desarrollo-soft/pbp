require 'digest/sha1'

class User
  include DataMapper::Resource

  validates_presence_of     :username
  validates_uniqueness_of   :username,    :case_sensitive => false
  validates_format_of       :username,    :with => /\A[a-z0-9\.]+\Z/i
  validates_presence_of     :email
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :email,    :case_sensitive => false
  validates_format_of       :email,    :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_presence_of     :new_password,                   :if => :password_required
  validates_presence_of     :new_password_confirmation,      :if => :password_required
  validates_length_of       :new_password, :within => 4..40, :if => :password_required
  validates_confirmation_of :new_password,                   :if => :password_required
  before :save, :generate_password
  after :save, :verify_invites

  # property <name>, <type>
  property :id, Serial
  property :username, String
  property :password, String
  property :email, String

  # temp unhashed password
  attr_accessor :new_password
  attr_accessor :new_password_confirmation

  def self.authenticate(username, password)
    hashed_password = Digest::SHA1.hexdigest(password)
    account = first(:conditions => { :username => username }) if username.present?
    account && account.password == hashed_password ? account : nil
  end

  def verify_invites
    CampaignInviteEmail.all(:email => self.email) do |i|
      invite = CampaignInviteUser.new
      invite.user_id = self[:id]
      invite.campaign_id = i.campaign_id
      if invite.save
        i.destroy
      end
    end
  end

  private
    def generate_password
      return if self.new_password.blank?
      self.password = Digest::SHA1.hexdigest(self.new_password)
      self.new_password = nil
      self.new_password_confirmation = nil
    end

    def password_required
      password.blank?
    end
end
