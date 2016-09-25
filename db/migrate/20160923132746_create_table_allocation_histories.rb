class CreateTableAllocationHistories < ActiveRecord::Migration[5.0]
  def up
    create_table :allocation_histories do |t|
      t.references :item
      t.references :user
      t.string :status
      t.timestamps
    end
    add_index :allocation_histories, ["item_id", "user_id"]
  end
  def down
    drop_table :allocation_histories
  end
end
