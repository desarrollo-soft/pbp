migration 6, :create_streams do
  up do
    create_table :streams do
      column :id, DataMapper::Property::Integer, :serial => true
      column :campaign_id, DataMapper::Property::Integer
      column :user_id, DataMapper::Property::Integer
      column :timestamp, DataMapper::Property::Integer
      column :type, DataMapper::Property::String
    end
  end

  down do
    drop_table :streams
  end
end
