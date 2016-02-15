class Attendee < ActiveRecord::Base
  belongs_to :order
  belongs_to :public_event
  belongs_to :private_event


end
