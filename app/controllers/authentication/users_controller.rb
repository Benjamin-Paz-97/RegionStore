class Authentication::UsersController < ApplicationController
  skip_before_action :protect_pages_admin

  def new
    @user = User.new
  end

  def create
    user_repo = AdapterUserRepository.new
    @user = User.new(user_params)

    if user_repo.save(@user) # Primero validamos y luego persistimos
      session[:user_id] = @user.id
      redirect_to productos_path, notice: "Registro exitoso"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :admin)
  end
end
