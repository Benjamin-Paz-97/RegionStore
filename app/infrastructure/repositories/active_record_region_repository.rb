module Infrastructure
    module Repositories
      class ActiveRecordRegionRepository
        def all
          ::Region.all
        end
  
        def find_by_id(id)
          ::Region.find_by(id: id)
        end
  
        def save(region)
          ::Region.create!(region_params(region))
        end
  
        def update(region)
          region.save!
        end
  
        def destroy(id)
          region = ::Region.find_by(id: id)
          region&.destroy
        end
  
        private
  
        def region_params(region)
          { name: region.name }
        end
      end
    end
  end
  