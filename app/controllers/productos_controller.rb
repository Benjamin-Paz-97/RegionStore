# app/controllers/productos_controller.rb
class ProductosController < ApplicationController
  skip_before_action :protect_pages_admin, only: [:index, :show]

  def index
    producto_repository = Infrastructure::Repositories::ActiveRecordProductoRepository.new
    list_productos = Domains::UseCases::ListProductos.new(producto_repository)

    @pagy, @productos = pagy(
      list_productos.call(
        region_id: params[:region_id],
        order_by: params[:order_by],
        page: params[:page]
      ), items: 10
    )
    @regions = Region.order(name: :asc)
  end

  def new
    authorize!
    @producto = Producto.new
  end

  def create
    authorize!
    producto_repository = Infrastructure::Repositories::ActiveRecordProductoRepository.new
    create_producto = Domains::UseCases::CreateProducto.new(producto_repository)

    begin
      create_producto.call(producto_params.to_h)
      redirect_to productos_path, notice: "El producto ha sido creado correctamente"
    rescue StandardError => e
      @producto = Producto.new(producto_params)
      render :new, status: :unprocessable_entity, alert: e.message
    end
  end

  def show
    producto_repository = Infrastructure::Repositories::ActiveRecordProductoRepository.new
    show_producto = Domains::UseCases::ShowProducto.new(producto_repository)

    @producto = show_producto.call(id: params[:id])
  end

  def edit
    authorize!
    @producto = Producto.find(params[:id]) # Podrías usar un caso de uso para esto también
  end

  def update
    producto_repository = Infrastructure::Repositories::ActiveRecordProductoRepository.new
    update_producto = Domains::UseCases::UpdateProducto.new(producto_repository)

    begin
      update_producto.call(id: params[:id], **producto_params.to_h)
      redirect_to producto_path(params[:id]), notice: "El producto ha sido actualizado correctamente"
    rescue StandardError => e
      @producto = Producto.find(params[:id])
      render :edit, status: :unprocessable_entity, alert: e.message
    end
  end

  def destroy
    authorize!
    producto_repository = Infrastructure::Repositories::ActiveRecordProductoRepository.new
    delete_producto = Domains::UseCases::DeleteProducto.new(producto_repository)

    begin
      delete_producto.call(id: params[:id])
      redirect_to productos_path, notice: "Producto eliminado con éxito", status: :see_other
    rescue StandardError => e
      redirect_to productos_path, alert: e.message
    end
  end

  def add_to_cart
    if current_user
      cart_repository = Infrastructure::Repositories::ActiveRecordCartRepository.new
      add_to_cart = Domains::UseCases::AddToCart.new(cart_repository)

      begin
        add_to_cart.call(user_id: current_user.id, producto_id: params[:id], quantity: 1)
        redirect_to productos_path, notice: "Producto añadido al carrito"
      rescue StandardError => e
        redirect_to productos_path, alert: e.message
      end
    else
      redirect_to login_path, alert: "Debes iniciar sesión para añadir productos al carrito"
    end
  end

  private

  def producto_params
    params.require(:producto).permit(:titulo, :description, :price, :photo, :region_id)
  end
end
