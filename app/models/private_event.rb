class PrivateEvent < ActiveRecord::Base
  has_many   :orders
  has_many   :attendees
  belongs_to :experience
  belongs_to :location
  belongs_to :artist

  obfuscate_id

  validates_presence_of :name, :description, :date, :start_time, :end_time, :available_slots, :phone, :email, :how_hear

end
