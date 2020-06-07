class User < ApplicationRecord
    attr_accessor :remember_token
    before_save :downcase_email
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    
    
#クラスメソッド　トークン生成  
class << self
    def new_token
      SecureRandom.urlsafe_base64
    end

    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
end

#トークン関係
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

    
    
    validates :name,
        presence: true,
        length: {maximum: 50}
    validates :email,
        presence: true,
        length: {maximum: 255},
        format: {with: VALID_EMAIL_REGEX},
        uniqueness: {case_sensitive: false}
        
    has_secure_password
    validates :password,
      presence: true,
      length: { minimum: 6 }
    
    private
    
    def downcase_email
        email.downcase
    end
        
end
