class AddHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :name
      t.string :paypal_email
      t.string :charity_id
      t.string :details
      t.string :host, null: false
      t.timestamps
    end
    add_index :hosts, :host

    create_table :subscriptions do |t|
      t.string :filter
      t.timestamps
    end
    add_index :subscriptions, :filter

    create_table :messages do |t|
      t.string :text
      t.string :type
      t.string :sender_host
      t.string :details
      t.string :host, null: false
      t.timestamps
    end
    add_index :messages, :type
    add_index :messages, :sender_host
  end
end
