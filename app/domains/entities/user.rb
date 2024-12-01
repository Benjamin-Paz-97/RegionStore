
module Domains
    module Entities
      class User
        attr_reader :email, :username, :password, :admin
  
        def initialize(email:, username:, password:, admin: false)
          @username = username.downcase
          @password = password
          @admin = admin || false
          @admin ||= false # Aseguramos booleano
          @username.downcase!
        end
  
        def admin?
          @admin
        end
      end
    end
  end
  