class RegionsController < ApplicationController
  before_action :authorize!
  def index
    @regions = Region.all
  end

  def new
    @region = Region.new
  end

  def edit
    region_repo = AdapterRegionRepository.new
    region_repo.edit(region)
  end

  def create
    region_repo = AdapterRegionRepository.new
    @region = region_repo.save(region_params) # Pasa los atributos procesados al repositorio

    if @region
      redirect_to regions_path, notice: "Región creada con éxito."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
      region_repo = AdapterRegionRepository.new
      @region = Region.find(params[:id]) # Busca la región usando el ID
  
      if region_repo.update(@region, region_params) # Pasa los datos procesados al repositorio
        redirect_to regions_url(@region), notice: "Región actualizada con éxito."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    region_repo = AdapterRegionRepository.new
    @region = Region.find(params[:id]) # Busca la región usando el ID
    if region_repo.eliminar(@region)
      redirect_to regions_url, notice: "region eliminada correctamente."
    end
  end

  private

    def region
      @region = Region.find(params[:id])
    end

    def region_params
      params.require(:region).permit(:name)
    end
end
