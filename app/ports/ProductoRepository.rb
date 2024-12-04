class ProductoRepository
    def save(producto)
      raise NotImplementedError, "Este método debe ser implementado por el adaptador"
    end
  
    def show(id)
      raise NotImplementedError, "Este método debe ser implementado por el adaptador"
    end
  
    def update(id, attributes)
      raise NotImplementedError, "Este método debe ser implementado por el adaptador"
    end
  
    def find(id)
      raise NotImplementedError, "Este método debe ser implementado por el adaptador"
    end
  
    def eliminar(producto)
      raise NotImplementedError, "Este método debe ser implementado por el adaptador"
    end
  
    def find_all
      raise NotImplementedError, "Este método debe ser implementado por el adaptador"
    end
  end
  