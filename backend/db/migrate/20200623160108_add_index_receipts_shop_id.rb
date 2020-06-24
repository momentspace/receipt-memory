class AddIndexReceiptsShopId < ActiveRecord::Migration[6.0]
  def change
    add_index :receipts, :shop_id
  end
end
