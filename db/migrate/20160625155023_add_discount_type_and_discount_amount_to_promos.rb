class AddDiscountTypeAndDiscountAmountToPromos < ActiveRecord::Migration
  def change
    add_column :promos, :discount_type, :integer
    add_column :promos, :discount_amount, :decimal, precision: 8, scale: 2
  end
end
