def current_user
  if session[:user_id]
    @current_user = User.find(session[:user_id])
  end
end

def logged_in?
  !session[:user_id].nil?
end

module CoreExtensions
  module String
    def to_slug
      self.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
    end
  end
end

# Adds to_slug to String class
String.include(CoreExtensions::String)