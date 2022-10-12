# frozen_string_literal: true

# module PapMon
module PapMon
  # Dataset class
  class Dataset
    def initialize(dataset_data)
      @dataset_data = dataset_data
    end

    def dataset_id
      @dataset_data['id']
    end

    def name
      @dataset_data['name']
    end

    def full_name
      @dataset_data['full_name']
    end

    def dataset_url
      @dataset_data['url']
    end
  end
end
