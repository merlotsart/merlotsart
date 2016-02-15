class CreatePrivateEvents < ActiveRecord::Migration
  def change
    create_table :private_events do |t|
      t.string   :status, default: 'Pending'
      t.integer  :available_slots
      t.integer  :purchased_slots
      t.string   :name
      t.string   :event_type
      t.text     :description
      t.integer  :price
      t.date     :date
      t.time     :start_time
      t.time     :end_time
      t.string   :address
      t.string   :city
      t.string   :state
      t.string   :zip
      t.boolean  :live
      t.string   :occasion
      t.string   :phone
      t.string   :email
      t.string   :how_hear
      t.string   :employee_referral
      t.text     :special_request

      t.belongs_to :artist, index: true
      t.belongs_to :experience, index: true
      t.belongs_to :location, index: true

      t.timestamps null: false
    end
  end
end
