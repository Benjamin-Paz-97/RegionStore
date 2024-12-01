
module Domains
    module Entities
      class Producto
        attr_reader :titulo, :description, :price, :region_id, :photo
  
        def initialize(titulo:, description:, price:, region_id:, photo: nil)
          @titulo = titulo
          @description = description
          @price = price
          @region_id = region_id
          @photo = photo
          validate!
        end
  
        def validate!
          raise "El título no puede estar vacío" if @titulo.nil? || @titulo.strip.empty?
          raise "La descripción no puede estar vacía" if @description.nil? || @description.strip.empty?
          raise "El precio debe ser un valor positivo" if @price.nil? || @price <= 0
        end
      end
    end
  end
  