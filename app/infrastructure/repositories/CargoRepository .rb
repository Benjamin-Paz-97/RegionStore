class CargoRepository
    def create(monto)
      cargo = Cargo.new(monto: monto, estado: :creado)
      cargo.save
      cargo
    end
  end
  