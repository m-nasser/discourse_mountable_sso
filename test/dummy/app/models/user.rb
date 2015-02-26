class User < ActiveRecord::Base

  attr_accessor :password

  before_save :encrypt_password
  after_save :clear_password
  attr_accessible :username, :email, :password, :password_confirmation
  validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  validates :password, :confirmation => true
  validates_length_of :password, :in => 6..20, :on => :create



  def self.authenticate(username_or_email="", login_password="")

    user = User.find_by_username(username_or_email)

    if user && user.match_password(login_password)
      return user
    else
      return false
    end
  end   

  def match_password(login_password="")
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end



  def encrypt_password
    unless password.blank?
      self.salt = BCrypt::Engine.generate_salt
      self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    end
  end

  def clear_password
    self.password = nil
  end

end
