class CreateReceipts < ActiveRecord::Migration[6.0]
  def change
    create_table :receipts do |t|
      t.string :name
      t.integer :category
      t.references :shop, null: false, foreign_key: true
      t.references :editor, null: false, foreign_key: { to_table: :users }
      t.references :owner, null: false, foreign_key: { to_table: :users }
      t.timestamp :purchased_at

      t.timestamps
    end
  end
end
