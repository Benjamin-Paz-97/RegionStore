module Application
    module UseCases
      class ManageRegion
        def initialize(region_repository)
          @region_repository = region_repository
        end
  
        def create(region_params)
          region = Region.new(region_params)
          @region_repository.save(region)
          region
        end
  
        def update(region, region_params)
          region.assign_attributes(region_params)
          @region_repository.update(region)
          region
        end
  
        def destroy(region)
          @region_repository.destroy(region.id)
        end
      end
    end
  end
  