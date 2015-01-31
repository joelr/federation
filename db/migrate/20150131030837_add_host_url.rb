class AddHostUrl < ActiveRecord::Migration
  def change
    add_column :hosts, :url, :string
  end
end
