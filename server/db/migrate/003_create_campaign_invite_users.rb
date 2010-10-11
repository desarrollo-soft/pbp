migration 3, :create_campaign_invite_users do
  up do
    create_table :campaign_invite_users do
      column :id, DataMapper::Property::Integer, :serial => true
      column :campaign_id, DataMapper::Property::Integer
      column :user_id, DataMapper::Property::Integer
    end
  end

  down do
    drop_table :campaign_invite_users
  end
end
