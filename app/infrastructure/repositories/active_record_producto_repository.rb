# app/infrastructure/repositories/active_record_producto_repository.rb
module Infrastructure
  module Repositories
    class ActiveRecordProductoRepository
      def save(producto)
        ::Producto.create!(
          titulo: producto.titulo,
          description: producto.description,
          price: producto.price,
          region_id: producto.region_id,
          photo: producto.photo
        )
      end

      def find_by_id(id)
        ::Producto.find_by(id: id)
      end

      def filter_and_order(region_id: nil, order_by: nil, page: nil)
        scope = ::Producto.all
        scope = scope.where(region_id: region_id) if region_id.present?
        scope = scope.order(order_by) if order_by.present?
        scope
      end
    end
  end
end
