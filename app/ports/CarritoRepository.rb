class CarritoRepository
    # Añadir un producto al carrito de un usuario
    def add_product_to_cart(user_id, producto_id)
      raise NotImplementedError, 'Este método debe ser implementado por el adaptador.'
    end
  
    # Eliminar un producto del carrito
    def remove_product_from_cart(carrito)
      raise NotImplementedError, 'Este método debe ser implementado por el adaptador.'
    end
  
    # Obtener todos los productos de un usuario en el carrito
    def get_user_cart(user_id)
      raise NotImplementedError, 'Este método debe ser implementado por el adaptador.'
    end
  end
  