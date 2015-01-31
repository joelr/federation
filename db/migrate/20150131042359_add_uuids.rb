class AddUuids < ActiveRecord::Migration
  def change
    add_column :messages, :uuids, :string
    add_column :messages, :filter, :string
    add_index :messages, :uuids
    add_index :messages, :filter
  end
end
