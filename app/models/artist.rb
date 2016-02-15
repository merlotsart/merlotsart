class Artist < ActiveRecord::Base
  has_many :public_events
  has_many :private_events

  obfuscate_id

  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/artist/:style/avatar.png", :storage => :s3, :bucket => "classphotos", :url =>':s3_domain_url',
  :path => '/:class/:attachment/:id_partition/:style/:filename'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :name, :bio, presence: true

end
