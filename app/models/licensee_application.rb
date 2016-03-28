class LicenseeApplication < ActiveRecord::Base

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :phone, presence: true
  validates :interested_locations, presence: true

  def full_name
    first_name + " " + last_name
  end

end
