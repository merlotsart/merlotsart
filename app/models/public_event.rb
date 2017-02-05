class PublicEvent < ActiveRecord::Base
  has_many   :orders
  has_many   :attendees
  belongs_to :experience
  belongs_to :location
  belongs_to :artist

  obfuscate_id

  after_create :create_slots
  after_update :update_slots

  validates_presence_of :name,
                        :description,
                        :date,
                        :start_time,
                        :artist_id,
                        :available_slots,
                        :end_time,
                        :price,
                        :experience,
                        :location,
                        :artist

  has_attached_file :image, :styles => { :medium => "300x300>",
                                         :small => "200x200#",
                                         :thumb => "100x100#" },
                            :default_url => "/images/missing/:style/missing.png",
                            :storage => :s3,
                            :bucket => "classphotos",
                            :url =>':s3_domain_url',
                            :path => '/:class/:attachment/:id_partition/:style/:filename'

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  scope :upcoming, -> { unscoped.where("date >= ?", Date.today).order(date: :asc) }


  def quantity_available
    num_slots_unsold - num_slots_locked
  end

  def num_slots_unsold
    slots_unsold.count
  end

  def slots_unsold
    self.attendees.where(name: nil)
  end

  def num_slots_sold
    self.attendees.where.not(name: nil).count
  end

  def num_slots_locked
    slots_locked.count
  end

  def slots_locked
    self.attendees.where('locked_until > ?', Time.now)
  end

  def slots_unlocked
    self.attendees.where('locked_until < ?', Time.now)
  end

  def create_slots
    self.available_slots.times { self.attendees.create }
  end

  def expired?
    self.date < Date.today
  end

  def update_slots
    slots_available = self.available_slots
    attendee_slots = self.attendees.count
    num_change =  attendee_slots - slots_available
    if num_change > 0
      [num_change, (num_change + (self.slots_unsold.count - num_change))].min.times { self.slots_unsold.sample.destroy }
    elsif num_change < 0
      (num_change*-1).times { self.attendees.create }
    end
  end

  def string_with_url(string)
    array = string.split(" ").map do |word|
      if /http/i.match(word)
        "<a href='#{word}' target='blank'>#{word}</a>"
      elsif /^www/i.match(word)
        "<a href='http://#{word}' target='blank'>#{word}</a>"
      elsif /.com/i.match(word)
        "<a href='http://#{word}' target='blank'>#{word}</a>"
      else
        word
      end
    end
    array.join(" ").html_safe
  end
end
