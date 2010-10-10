migration 2, :create_campaigns do
  up do
    create_table :campaigns do
      column :id, DataMapper::Property::Integer, :serial => true
      column :master_user_id, DataMapper::Property::Integer
      column :name, DataMapper::Property::String
    end
  end

  down do
    drop_table :campaigns
  end
end
