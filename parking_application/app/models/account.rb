class Account < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  belongs_to :person
  has_secure_password
  validates :password, presence: true

  accepts_nested_attributes_for :person

  before_create :encrypt_password

  PEPPER = '9782901ee15a5651b9f5'
  STRETCHES = 10

  def valid_password?(password)
    return false if encrypted_password.blank?
    bcrypt = ::BCrypt::Password.new(encrypted_password)
    password = ::BCrypt::Engine.hash_secret("#{password}#{PEPPER}", bcrypt.salt)
    password == encrypted_password
  end

  def password_digest(password)
    ::BCrypt::Password.create("#{password}#{PEPPER}", :cost => STRETCHES).to_s
  end

  def encrypt_password
    self.encrypted_password = password_digest(password)
  end
end
