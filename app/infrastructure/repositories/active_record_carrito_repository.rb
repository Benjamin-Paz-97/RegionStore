module Infrastructure
    module Repositories
      class ActiveRecordCarritoRepository
        def find_by_user_and_producto(user, producto)
          Carrito.find_by(user: user, producto: producto)
        end
  
        def create(carrito)
          carrito.save!
        end
  
        def destroy(carrito)
          carrito.destroy
        end
      end
    end
  end
  