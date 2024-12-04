class AdapterCarritoRepository
    def add_product_to_cart(user_id, producto_id)
      begin
        Carrito.create!(user_id: user_id, producto_id: producto_id)
      rescue ActiveRecord::RecordNotUnique
        :already_exists # Devuelve un símbolo si el producto ya está en el carrito
      rescue => e
        raise "Error al añadir producto al carrito: #{e.message}"
      end
    end
  
    def remove_product_from_cart(carrito)
      carrito.destroy
    end
  
    def get_user_cart(user_id)
      Carrito.includes(:producto).where(user_id: user_id)
    end
  end
  