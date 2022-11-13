# frozen_string_literal: true

module PapMon
  module PapersWithCode
    # Dataset Mapper for PapersWithCode API
    class DatasetMapper
      def initialize(gateway_class)
        @gateway_class = gateway_class
        @gateway = @gateway_class.new
      end

      def load_several(paper_id)
        @gateway.datasets_data(paper_id)['results'].map do |dataset|
          DatasetMapper.build_entity(dataset)
        end
      end

      def self.build_entity(data)
        DataMapper.new(data).build_entity
      end

      # Data Mapper for DatasetMapper
      class DataMapper
        def initialize(data)
          @data = data
        end

        def build_entity
          PapMon::Entity::Dataset.new(
            id: nil,
            origin_id:,
            name:,
            url:
          )
        end

        def origin_id
          @data['id']
        end

        def name
          @data['name']
        end

        # def full_name
        #   @data['full_name']
        # end

        def url
          @data['url']
        end
      end
    end
  end
end
