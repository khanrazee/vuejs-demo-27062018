class CreateUpworkRequest < ActiveRecord::Migration
  def change
    create_table :upwork_requests do |t|
      t.string :name
      t.string :email
      t.string :profile_url
      t.text :message
      t.integer :status, default: 0
      t.timestamps null: false
    end
  end
end
