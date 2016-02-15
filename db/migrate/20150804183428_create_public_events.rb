class CreatePublicEvents < ActiveRecord::Migration
  def change
    create_table :public_events do |t|
      t.string   :status
      t.integer  :available_slots
      t.integer  :purchased_slots
      t.integer  :byob_fee
      t.string   :name, index: true
      t.text     :description
      t.integer  :price
      t.date     :date, index: true
      t.time     :start_time
      t.time     :end_time
      t.string   :address
      t.string   :city
      t.string   :state
      t.string   :zip
      t.boolean  :live

      t.belongs_to :artist, index: true
      t.belongs_to :experience, index: true
      t.belongs_to :location, index: true

      t.timestamps null: false
    end
  end
end
