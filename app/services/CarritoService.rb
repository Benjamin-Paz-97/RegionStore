class CarritoService
    def initialize(carrito_repository)
      @carrito_repository = carrito_repository
    end
  
    # Añadir producto al carrito
    def add_product_to_cart(user_id, producto_id)
      @carrito_repository.add_product_to_cart(user_id, producto_id)
    end
  
    # Eliminar producto del carrito
    def remove_product_from_cart(carrito)
      @carrito_repository.remove_product_from_cart(carrito)
    end
  
    # Obtener productos del carrito de un usuario
    def get_user_cart(user_id)
      @carrito_repository.get_user_cart(user_id)
    end
  end
  