class AddIndexReceiptsCategory < ActiveRecord::Migration[6.0]
  def change
    add_index :receipts, :category
  end
end
