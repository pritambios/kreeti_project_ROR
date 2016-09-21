class CreateTableAlloctionHistory < ActiveRecord::Migration[5.0]
  def up
    create_table :alloction_histories do |t|
      t.references :item_id, index: true
      t.references :user_id, index: true
      t.timestamps
    end
  end

  def down
    drop_table :allocation_histories
  end
end
