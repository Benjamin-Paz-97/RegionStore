class AdapterUserRepository < UserRepository
  def save(user)
    # Asignamos directamente los atributos del dominio a un objeto de ActiveRecord
    @user = user
    @user.save
  end

  def find_by_email(email)
    record = ::User.find_by(email: email.downcase)
    record_to_domain(record) if record
  end

  def find_by_username(username)
    record = ::User.find_by(username: username.downcase)
    record_to_domain(record) if record
  end

  private

  def record_to_domain(record)
    User.new(
      email: record.email,
      username: record.username,
      password: record.password_digest,
      admin: record.admin
    )
  end
end
