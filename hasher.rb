require 'bcrypt'

class Hasher
  def self.make(password)
    BCrypt::Password.create(password)
  end

  def self.verify(user, password)
    BCrypt::Password.new(user.password) == password
  end
end
