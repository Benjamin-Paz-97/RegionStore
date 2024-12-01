module Application
    module UseCases
      class ManageCarrito
        def initialize(carrito_repository)
          @carrito_repository = carrito_repository
        end
  
        def add_to_cart(user, producto)
          carrito = @carrito_repository.find_by_user_and_producto(user, producto)
          
          if carrito
            raise 'El producto ya está en tu carrito'
          else
            carrito = Carrito.new(user: user, producto: producto)
            @carrito_repository.create(carrito)
          end
        end
  
        def remove_from_cart(carrito)
          @carrito_repository.destroy(carrito)
        end
      end
    end
  end
  