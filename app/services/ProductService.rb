module Services
  class ProductService
    def initialize(params = {})
      @params = params
    end

    def find_all(params)
      productos = Producto.all
      # Filtra productos basados en los parámetros
      productos = productos.where(region_id: params[:region_id]) if params[:region_id].present?
      productos = productos.order(:created_at) # O lo que desees en order_by
      productos = productos.page(params[:page]) # Para paginación
      productos
    end

    def find_products
      ::Producto.find_by(id: id)
    end

    def create
      product = Domains::Producto.new(@product_params)
      if product.valid?
        Adapters::ProductoAdapter.create(@product_params)
      else
        # Devuelve errores si el producto no es válido
        product.errors.full_messages
      end
    end

    def update(id)
      Adapters::ProductoAdapter.update(id, @product_params)
    end

    def destroy(id)
      Adapters::ProductoAdapter.destroy(id)
    rescue ActiveRecord::RecordNotFound
      false
    end

    private

    def filter_by_region_id(productos, region_id)
      return productos unless region_id.present?
      productos.where(region_id: region_id)
    end

    def sort(productos, order_by)
      order_by_query = Producto::ORDER_BY.fetch(order_by&.to_sym, Producto::ORDER_BY[:newest])
      productos.order(order_by_query)
    end

    def paginate(productos, page)
      pagy(productos, items: 10, page: page)
    end
  end
end
