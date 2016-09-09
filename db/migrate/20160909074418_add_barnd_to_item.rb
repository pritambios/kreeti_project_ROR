class AddBarndToItem < ActiveRecord::Migration[5.0]
  def change
      add_column :items, :brand_id, :integer
  end
end
