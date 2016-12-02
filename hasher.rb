class Hasher

  SALT = "$2a$10$0QhRjvut5MuGT02Orlspy."

  def self.make(password)
    BCrypt::Engine.hash_secret(password, SALT)
  end
end