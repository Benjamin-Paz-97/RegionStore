class ProductosController < ApplicationController
  skip_before_action :protect_pages_admin, only: [:index, :show]
  def index
    @pagy, @productos = pagy(FindProductos.new.call(producto_prams_index), items: 10)
    @regions = Region.order(name: :asc)
    if params[:region_id]
      @productos = @productos.where(region_id: params[:region_id])
    end

    order_by = Producto::ORDER_BY.fetch(params[:order_by]&.to_sym,Producto::ORDER_BY[:newest])


  end

  def new
    authorize!
    @producto = Producto.new
  end

  def create
    authorize!
    @producto = Producto.new(producto_params)
    producto_repo = AdapterProductoRepository.new

    if producto_repo.save(@producto)
      redirect_to productos_path, notice: "Producto creado exitosamente."
    else
      render :new, status: :unprocessable_entity
    end


  end

  def show
    producto_repo = AdapterProductoRepository.new
    producto_repo.Show_Producto(producto)
  end

  def edit
    authorize!
    producto_repo = AdapterProductoRepository.new
    producto_repo.edit(producto)
  end

  def update
    producto_repo = AdapterProductoRepository.new
    @producto =  Producto.find(params[:id])

    if producto_repo.update(@producto.id, producto_params)
      redirect_to producto_path(@producto), notice: "El producto ha sido actualizado correctamente."
    else
      @errors = @producto.errors.full_messages 
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    producto_repo = AdapterProductoRepository.new
    @producto = producto_repo.find(params[:id]) # Utiliza el repositorio para buscar el producto
  
    if @producto
      Carrito.where(producto_id: @producto.id).destroy_all # Elimina los carritos relacionados
      producto_repo.Eliminar(@producto)
      redirect_to productos_path, notice: "Producto eliminado con éxito", status: :see_other
    else
      redirect_to productos_path, alert: "El producto no existe o no se pudo eliminar", status: :unprocessable_entity
    end
  end
  

  def add_to_cart
    if current_user
      product = Producto.find(params[:id])
      current_user.cart_items.create(producto: producto, quantity: 1)
      redirect_to productos_path, notice: 'Producto añadido al carrito'
    else
      redirect_to login_path, alert: 'Debes iniciar sesión para añadir productos al carrito'
    end
  end


  private

  def producto_params
    params.require(:producto).permit(:titulo, :description, :price, :photo,:region_id)
  end

  def producto_prams_index
    params.permit( :region_id , :order_by, :page)
  end

  def producto
    @producto =  Producto.find(params[:id])
  end
end