class AdapterRegionRepository

    def save(attributes)
        region = Region.new(attributes) # Crea una nueva instancia de Region con los atributos proporcionados
        if region.save
          region
        else
          nil # Devuelve nil si no se puede guardar
        end
    end

    def edit(region)
        region
    end
    
    def create
        @region = Region.new(region_params)
        if @region.save
          redirect_to regions_url(), notice: "Region creada con éxito."
        else
          render :new, status: :unprocessable_entity
        end
    end
    
    def update(region, attributes)
        if region.update(attributes)
          true
        else
          false
        end
    end
    
    def eliminar(region)
        region.destroy
    end

    private
    def region_params
        params.require(:region).permit(:name)
    end
end