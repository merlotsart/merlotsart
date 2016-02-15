class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.belongs_to :public_event
      t.belongs_to :private_event
      t.belongs_to :user
      t.string     :name
      t.string     :status, default: 'Processed'
      t.string     :email
      t.string     :phone
      t.string     :type
      t.integer    :total
      t.integer    :quantity
      t.string     :payment_id

      t.timestamps null: false
    end
  end
end
