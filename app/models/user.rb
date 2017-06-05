class User < ActiveRecord::Base

  ratyrate_rater
  # associations
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :places
  has_many :comments, as: :commentable

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

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token.first(8)
  #     user.name = auth.info.name   # assuming the user model has a name
  #     user.avatar = auth.info.image # assuming the user model has an image
  #     # If you are using confirmable and the provider(s) you use validate emails,
  #     # uncomment the line below to skip the confirmation emails.
  #     # user.skip_confirmation!
  #   end
  # end
  #
  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end

  # alternative emo
  # def self.from_omniauth(auth)
  #   user = where("provider = ? AND uid = ?", auth["provider"], auth["uid"]).first || create_from_omniauth(auth)
  # end
  #
  # def self.create_from_omniauth(auth)
  #   create do |user|
  #     user.provider = auth["provider"]
  #     user.uid = auth["uid"]
  #     user.email = auth["info"]["email"] if auth["info"]["email"]
  #   end
  # end
  #
  # def self.new_with_session(params, session)
  #   if session["devise.user_attributes"]
  #     new(session["devise.user_attributes"]) do |user|
  #       user.attributes = params
  #     end
  #   else
  #     super
  #   end
  # end

  # lb2_3
  def self.from_omniauth(auth)
    user = where(provider: auth.provider, uid: auth.uid).first
    user = find_by( email:  auth.info.email ) unless user
    unless user
      pass        = Devise.friendly_token[0,20]
      array       = auth.info.name.split
      surname     = array.last
      array       = array - [array.last]
      name        = array.join(' ').to_s
      user = new(
        name: name,
        surname: surname,
        provider: auth.provider,
        uid: auth.uid,
        email: auth.info.email.presence,
        password: pass,
        password_confirmation: pass,
        avatar: auth.info.image
      )
      # Confirm user
      # user.skip_confirmation!
      user.save!
    end
    if user.provider.nil? or user.uid.nil?
      user.provider = auth.provider
      user.uid = auth.uid
      user.save!
    end
    user
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
