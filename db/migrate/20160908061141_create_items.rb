class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.text :name
      t.text :description
      t.text :model_number
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :total_value

      t.timestamps
    end
  end
end
