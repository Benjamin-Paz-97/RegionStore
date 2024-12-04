class CarritosController < ApplicationController
    skip_before_action :protect_pages_admin
    before_action :protect_pages_login

    def index
      carrito_repo = AdapterCarritoRepository.new
      @carritos = carrito_repo.get_user_cart(Current.user.id)
    end

    def create
      carrito_repo = AdapterCarritoRepository.new
      result = carrito_repo.add_product_to_cart(Current.user.id, params[:producto_id])
      case result
      when :already_exists
        redirect_to productos_path, alert: "¡El producto ya está en tu carrito!"
      else
        redirect_to productos_path, notice: "Producto añadido al carrito"
      end
    rescue => e
      redirect_to productos_path, alert: "Hubo un error al añadir el producto al carrito: #{e.message}"
    end

    def destroy
      carrito_repo = AdapterCarritoRepository.new      
      if carrito_repo.remove_product_from_cart(@carrito = Carrito.find_by(params[:id]))
        redirect_to carritos_path, notice: "Producto eliminado del carrito exitosamente."
      else
        redirect_to carritos_path, alert: "El producto no existe en tu carrito."
      end
    end


    private

    def carrito
        @carrito = Carrito.find(params[:id])
      end
    def producto
        @producto ||= Producto.find(params[:producto_id])
    end
end
