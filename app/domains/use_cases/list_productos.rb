module Domains
    module UseCases
      class ListProductos
        def initialize(producto_repository)
          @producto_repository = producto_repository
        end
  
        def call(region_id: nil, order_by: nil, page: nil)
          @producto_repository.filter_and_order(region_id: region_id, order_by: order_by, page: page)
        end
      end
    end
  end
  