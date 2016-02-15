class Experience < ActiveRecord::Base
  has_many :public_event
  has_many :private_event
end
