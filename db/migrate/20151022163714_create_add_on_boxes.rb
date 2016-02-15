class CreateAddOnBoxes < ActiveRecord::Migration
  def change
      add_column :public_events, :unlimited_wine, :integer, default: 0
      add_column :public_events, :unlimited_mimosas, :integer, default: 0
      add_column :public_events, :voucher_upgrade_fee, :integer, default: 0
  end
end
