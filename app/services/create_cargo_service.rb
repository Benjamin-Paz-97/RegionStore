class CreateCargoService
    def initialize(user, monto)
      @user = user
      @monto = monto
    end
  
    def call
      # Crea el cargo
      cargo = Cargo.new(monto: @monto, estado: :creado)
      if cargo.save
        # Elimina los productos del carrito del usuario
        Carrito.where(user: @user).destroy_all if Carrito.exists?(user: @user)
      end
      cargo
    end
  end
  