# app/controllers/carritos_controller.rb
class CarritosController < ApplicationController
  skip_before_action :protect_pages_admin
  before_action :protect_pages_login
  before_action :set_carrito, only: :destroy
  before_action :set_producto, only: :create

  def index
    @carritos = Current.user.carritos.includes(:producto)
  end

  def create
    begin
      manage_carrito.add_to_cart(Current.user, @producto)
      redirect_to productos_path, notice: "Producto añadido al carrito"
    rescue => e
      redirect_to productos_path, alert: "¡El producto ya está en tu carrito! #{e.message}"
    end
  end

  def destroy
    if @carrito
      manage_carrito.remove_from_cart(@carrito)
      redirect_to carritos_path, notice: "Producto eliminado del carrito exitosamente."
    else
      redirect_to carritos_path, alert: "El producto no existe en tu carrito."
    end
  end

  private

  def set_carrito
    @carrito = Carrito.find_by(id: params[:id])
  end

  def set_producto
    @producto ||= Producto.find(params[:producto_id])
  end

  def manage_carrito
    @manage_carrito ||= Application::UseCases::ManageCarrito.new(Infrastructure::Repositories::ActiveRecordCarritoRepository.new)
  end
end
