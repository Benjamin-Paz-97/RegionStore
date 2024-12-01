module Application
    module UseCases
      class ListRegions
        def initialize(region_repository)
          @region_repository = region_repository
        end
  
        def call
          @region_repository.all
        end
      end
    end
  end
  