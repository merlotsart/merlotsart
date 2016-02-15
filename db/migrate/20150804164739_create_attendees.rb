class CreateAttendees < ActiveRecord::Migration
  def change
    create_table :attendees do |t|
      t.string   :name
      t.string   :email
      t.string   :phone
      t.boolean  :attended
      t.string   :discount_code
      t.integer  :locked_by
      t.datetime :locked_until, default: Time.now

      t.belongs_to :order
      t.belongs_to :public_event
      t.belongs_to :private_event

      t.timestamps null: false
    end
  end
end
