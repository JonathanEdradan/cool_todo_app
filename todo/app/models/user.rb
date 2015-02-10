# require 'bcrypt'

class User < ActiveRecord::Base
	has_secure_password
	has_many :tasks, as: :taskable
	# BCrypt::Engine.cost = 12

	# attr_reader :password

	# validates_confirmation_of :password
	# validates_presence_of :password_digest

	# def password=(pswrd)
	# 	if pswrd.nil?
	# 		self.password_digest = nil
	# 	else
	# 		@password = pswrd
	# 		self.password_digest = BCrypt::Password.create(@password)
	# 	end
	# end

	# def authenticate(pswrd)
	# 	if BCrypt::Password.new(password_digest) == pswrd
	# 		self
	# 	else
	# 		false
	# 	end
	# end

  def self.confirm(email, pswrd)
    user = User.find_by({email: email})
    if user
    	user.authenticate(pswrd)
  	else
  		false
  	end
  end
end
