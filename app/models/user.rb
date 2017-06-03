class User < ActiveRecord::Base
  # associations
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :places

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  accepts_nested_attributes_for :interests
  # Virtual attributes
  attr_accessor :is_generated_password

  # Scopes
  scope :active, -> { where(is_active: true) }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :async,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :omniauthable,
         :omniauth_providers => [:facebook]

  # omniauth methods
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  # Helpers
  audited except: [:password]

  # Validations
  validates_presence_of :name, :email, :surname
  validates :email, uniqueness: true

  # Callbacks
  after_commit :send_login_info, on: :create
  before_validation :create_password, on: :create
  after_initialize do |obj|
    obj.is_generated_password = false
  end

  def active_for_authentication?
    super && self.is_active
  end

  def full_name
    "#{self.name} #{self.surname}"
  end

  private

  def create_password
    if self.password.nil?
      password                    = Devise.friendly_token.first(8)
      self.password               = password
      self.password_confirmation  = password
      self.is_generated_password  = true
    end
  end

  def send_login_info
    UserMailer.login_info(self.id, self.password).deliver_later! if self.is_generated_password
  end
end
