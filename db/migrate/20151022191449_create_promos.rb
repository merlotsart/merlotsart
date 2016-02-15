class CreatePromos < ActiveRecord::Migration
  def change
    create_table :promos do |t|
      t.string  :email
      t.string  :code
      t.integer :discount_percentage
      t.integer :number_of_uses, default: 1
      t.integer :number_of_times_used, default: 0
      t.date    :expiration_date, default: Date.today + 1.year

      t.timestamps null: false
    end

    add_index :promos, [:code, :email], unique: true
  end
end
