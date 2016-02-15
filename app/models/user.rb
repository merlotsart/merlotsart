class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :orders

  obfuscate_id

  # after_create :send_welcome
  # before_action :authenticate_user!

  validates :phone, format: { with: /\d{3}-\d{3}-\d{4}/, message: "bad format" }
  validates :name, presence: true

  def send_welcome
    @user = User.last
    UserMailer.welcome_email(@user).deliver_later
  end
end
