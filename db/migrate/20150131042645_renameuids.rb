class Renameuids < ActiveRecord::Migration
  def change
    rename_column :messages, :uuids, :uuid
  end
end
