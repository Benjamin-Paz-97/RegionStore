# app/controllers/regions_controller.rb
class RegionsController < ApplicationController
  before_action :authorize!
  before_action :set_region, only: [:edit, :update, :destroy]

  def index
    @regions = list_regions
  end

  def new
    @region = Region.new
  end

  def edit
  end

  def create
    @region = manage_region.create(region_params)
    if @region.persisted?
      redirect_to regions_url, notice: "Región creada con éxito."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if manage_region.update(@region, region_params)
      redirect_to regions_url(@region), notice: "Región actualizada con éxito."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    manage_region.destroy(@region)
    redirect_to regions_url, notice: "Región eliminada correctamente."
  end

  private

  def set_region
    @region = Region.find(params[:id])
  end

  def region_params
    params.require(:region).permit(:name)
  end

  def manage_region
    @manage_region ||= Application::UseCases::ManageRegion.new(Infrastructure::Repositories::ActiveRecordRegionRepository.new)
  end

  def list_regions
    @list_regions ||= Application::UseCases::ListRegions.new(Infrastructure::Repositories::ActiveRecordRegionRepository.new).call
  end
end
