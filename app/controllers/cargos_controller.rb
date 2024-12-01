class CargosController < ApplicationController
  before_action :protect_pages_login
  
  def index
    authorize!
    @cargos = Cargo.all
  end

  def new
    @cargo = Cargo.new
  end

  def create
    cargo = CreateCargoService.new(Current.user, cargo_params[:monto]).call
    if cargo.persisted?
      redirect_to productos_path, notice: "Pago realizado con éxito"
    else
      render :new, status: :unprocessable_entity, alert: "Fallo en el proceso de pago"
    end
  end

  private

  def cargo_params
    params.require(:cargo).permit(:monto)
  end
end
