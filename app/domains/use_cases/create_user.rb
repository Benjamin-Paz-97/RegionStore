
# app/domains/use_cases/create_user.rb
module Domains
    module UseCases
      class CreateUser
        def initialize(user_repository)
          @user_repository = user_repository
        end
  
        def call(email:, username:, password:, admin: false)
          user = Domains::Entities::User.new(
            email: email,
            username: username,
            password: password,
            admin: admin
          )
          @user_repository.save(user)
        end
      end
    end
  end
  