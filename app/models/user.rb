class User < ApplicationRecord
  has_secure_password

  RFC_FORMAT = /\A[A-Z&Ñ]{3,4}\d{6}[A-Z0-9]{3}\z/

  has_many :collaborators, dependent: :destroy
  has_many :managed_users, foreign_key: :owner_user_id, dependent: :destroy, inverse_of: :owner_user
  has_many :created_managed_users, class_name: "ManagedUser", foreign_key: :created_by_id, dependent: :destroy

  before_validation :normalize_email_and_rfc

  validates :name, :email, :rfc, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :rfc, uniqueness: { case_sensitive: false }, format: { with: RFC_FORMAT, message: "debe tener una estructura valida" }
  validates :password, length: { minimum: 8 }, allow_nil: true

  def rotate_session_token!
    update!(session_token: SecureRandom.hex(32))
  end

  private

  def normalize_email_and_rfc
    self.email = email.to_s.strip.downcase
    self.rfc = rfc.to_s.strip.upcase
  end
end
