# frozen_string_literal: true

class AddIndexReceiptsOwnerId < ActiveRecord::Migration[6.0]
  def change
    add_index :receipts, :owner_id
  end
end
