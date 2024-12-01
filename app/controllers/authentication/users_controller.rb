# app/controllers/authentication/users_controller.rb
class Authentication::UsersController < ApplicationController
  skip_before_action :protect_pages_admin

  def create
    user_repository = Infrastructure::Repositories::ActiveRecordUserRepository.new
    create_user = Domains::UseCases::CreateUser.new(user_repository)

    create_user.call(
      email: params[:user][:email],
      username: params[:user][:username],
      password: params[:user][:password],
      admin: params[:user][:admin]
    )

    session[:user_id] = User.find_by(email: params[:user][:email]).id
    redirect_to productos_path, notice: "Registro exitoso"
  rescue StandardError => e
    redirect_to new_user_path, alert: "Error: #{e.message}"
  end
end
