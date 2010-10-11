migration 4, :create_campaign_invite_emails do
  up do
    create_table :campaign_invite_emails do
      column :id, DataMapper::Property::Integer, :serial => true
      column :campaign_id, DataMapper::Property::Integer
      column :email, DataMapper::Property::String
    end
  end

  down do
    drop_table :campaign_invite_emails
  end
end
