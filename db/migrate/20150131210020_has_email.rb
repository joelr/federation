class HasEmail < ActiveRecord::Migration
  def change
    add_column :hosts, :has_email, :boolean, default: false
  end
end
