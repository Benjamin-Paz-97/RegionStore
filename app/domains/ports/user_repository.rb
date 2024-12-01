
module Domains
    module Ports
      class UserRepository
        def save(user)
          raise NotImplementedError, "This is an interface!"
        end
      end
    end
  end
  