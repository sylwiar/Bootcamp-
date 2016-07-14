class Account < ActiveRecord::Base
  validates :email, presence: true, uniqueness: true
  belongs_to :person

  attr_accessor :password

  accepts_nested_attributes_for :person

  before_create :encrypt_password

  validates_confirmation_of :password, :on => :create
  validates_presence_of :password, :on => :create

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

  def self.authenticate!(email, password)
    account = Account.find_by_email(email)
    if account && account.valid_password?(password)
      account
    else
      nil
    end 
  end
end
