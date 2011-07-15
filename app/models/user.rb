class User < ActiveRecord::Base
  act_as_authentic do |config|
    #Configuration Options
    config.crypto_provider = Authlogic::CryptoProviders::MD5
  end
end
