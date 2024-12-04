class AdapterProductoRepository < ProductoRepository
    def save(producto)
      record = Producto.new(
        titulo: producto.titulo,
        description: producto.description,
        price: producto.price,
        region_id: producto.region.id
      )
  
      if record.save
        true
      else
        producto.errors.add(:base, record.errors.full_messages.join(', '))
        false
      end
    end
  
    def Show_Producto(producto)
        producto
    end
    def edit(producto)
        producto
    end

    def update(id, attributes)
        record = Producto.find_by(id: id)
        return false unless record
    
        if record.update(attributes)
          record_to_domain(record)
        else
          false
        end
    end

    def find(id)
        Producto.find_by(id: id) # Devuelve el producto si existe, de lo contrario nil
    end
    
    def Eliminar(producto)
        producto.destroy # Retorna true si se elimina correctamente, false en caso contrario
    rescue StandardError => e
        Rails.logger.error "Error al eliminar el producto: #{e.message}"
        false
    end
    
  
    def find_all
      Producto.all.map { |record| record_to_domain(record) }
    end
  
    private
  
    def record_to_domain(record)
        Producto.new(
          titulo: record.titulo,
          description: record.description,
          price: record.price,
          region: record.region,
          photo: record.photo.attached? ? record.photo.blob : nil # Convertir el archivo adjunto a un blob si existe
        )
    end
    
  end
  