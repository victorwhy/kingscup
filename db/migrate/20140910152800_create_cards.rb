class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :value
      t.string :suit
      t.string :rule

      t.timestamps
    end
  end
end
