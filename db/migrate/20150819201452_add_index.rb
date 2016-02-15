class AddIndex < ActiveRecord::Migration
  def change
    add_index :orders, :public_event_id
    add_index :attendees, :public_event_id
  end
end
