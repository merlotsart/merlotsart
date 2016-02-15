class AddNewPublicEventOptions < ActiveRecord::Migration
  def change
    add_column :public_events, :discount_code, :integer
  end
end
