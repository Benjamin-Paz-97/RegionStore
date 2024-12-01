
module Infrastructure
    module Repositories
      class ActiveRecordUserRepository < Domains::Ports::UserRepository
        def save(user)
          ::User.create!(
            email: user.email,
            username: user.username,
            password: user.password,
            admin: user.admin?
          )
        end
      end
    end
  end
  