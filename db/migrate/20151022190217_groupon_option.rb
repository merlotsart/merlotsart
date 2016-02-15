class GrouponOption < ActiveRecord::Migration
  def change
    add_column :public_events, :groupon, :boolean
  end
end
