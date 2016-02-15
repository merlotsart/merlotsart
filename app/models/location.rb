class Location < ActiveRecord::Base
  has_many :public_event
  has_many :private_event

  has_attached_file :image, :styles => { :medium => "500x500>", :small => "200x200#", :thumb => "100x100>" }, :default_url => "/images/location/:style/location.png", :storage => :s3, :bucket => "classphotos", :url =>':s3_domain_url',
  :path => '/:class/:attachment/:id_partition/:style/:filename'
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates_presence_of :name
end
