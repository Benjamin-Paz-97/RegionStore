class UserRepository
    def save(user)
      raise NotImplementedError, 'This method must be implemented in an adapter'
    end
  
    def find_by_email(email)
      raise NotImplementedError, 'This method must be implemented in an adapter'
    end
  end
  