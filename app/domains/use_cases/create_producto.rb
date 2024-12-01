
module Domains
    module UseCases
      class CreateProducto
        def initialize(producto_repository)
          @producto_repository = producto_repository
        end
  
        def call(attributes)
          producto = Domains::Entities::Producto.new(**attributes)
          @producto_repository.save(producto)
        end
      end
    end
  end
  