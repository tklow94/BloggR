class User < ApplicationRecord
    
    before_save { self.email = email.downcase } #self refernces each object of the user class before saving it runs the downcase method
    has_many :articles
    validates :username, presence: true, 
                        uniqueness: { case_sensitive: false }, 
                        length: { minimum: 3, maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i #capital to defined as a constant b/c not going to change
    validates :email, presence: true, 
                        uniqueness: { case_sensitive: false }, 
                        length: { maximum: 101},
                        format: { with: VALID_EMAIL_REGEX }
    has_secure_password
    
end