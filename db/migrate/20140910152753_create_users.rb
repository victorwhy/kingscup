class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :google_id
      t.string :google_pic
      t.string :profile_link
    
      t.timestamps
    end
  end
end
