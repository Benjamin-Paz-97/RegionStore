module Domains
    module UseCases
      class DeleteProducto
        def initialize(producto_repository)
          @producto_repository = producto_repository
        end
  
        def call(id:)
          producto = @producto_repository.find_by_id(id)
          raise "Producto no encontrado" unless producto
  
          @producto_repository.delete(producto)
        end
      end
    end
  end
  