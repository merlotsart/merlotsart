class AddGrouponCode < ActiveRecord::Migration
  def change
    add_column :orders, :groupon_code, :string
  end
end
