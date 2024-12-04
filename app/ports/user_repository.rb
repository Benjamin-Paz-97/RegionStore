class UserRepository
    def save(user)
      raise NotImplementedError
    end
  
    def find_by_email(email)
      raise NotImplementedError
    end
  
    def find_by_username(username)
      raise NotImplementedError
    end
  end
  