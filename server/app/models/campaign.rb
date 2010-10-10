class Campaign
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :master_user_id, Integer
  property :name, String

  belongs_to :master_user , 'User', :key => true
end
