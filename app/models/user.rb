class User < ActiveRecord::Base

  acts_as_authentic do |config|
    #Configuration Options
    config.crypto_provider = Authlogic::CryptoProviders::MD5
  end
  
has_attached_file :avatar, :styles => {:medium => "300x300>", :thumb => "100x100>"}

  has_and_belongs_to_many :congresos

  easy_roles :roles

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :login,  :presence => true,
                    :length   => { :maximum => 20 }
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => true
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => { :within => 6..20 }
  
end
