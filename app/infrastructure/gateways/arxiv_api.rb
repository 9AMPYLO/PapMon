# frozen_string_literal: true

require 'http'
require 'yaml'
require 'active_support/all'

# PaperWithCode API module
module PapMon
  # PaperWithCode API
  class ArxivApi
    def arxiv_paper
      parse(Request.new.arxiv_paper)
    end

    def parse(xml)
      arxiv_result = []

      xml_hash = Hash.from_xml(xml)
      xml_hash = xml_hash['feed']['entry']
      xml_hash.each do |paper_element|
        arxiv_paper = {}
        arxiv_paper['arxiv_id'] = paper_element['id'][21..30]
        arxiv_paper['primary_category'] = paper_element['primary_category']['term']
        arxiv_result.append(arxiv_paper)
      end
      arxiv_result
    end

    # request class
    class Request
      def get(url)
        http_response = HTTP.headers('Accept' => 'application/json').get(url)
        Response.new(http_response).tap do |response|
          raise response.error unless response.successful?
        end
      end

      def arxiv_paper
        get('http://export.arxiv.org/api/query?search_query=cat:cs.CV+OR+cat:cs.AI+OR+cat:cs.LG+OR+cat:cs.CL+OR+cat:cs.NE+OR+cat:stat.ML+&sortBy=lastUpdatedDate&sortOrder=descending&max_results=2')
      end
    end

    # Decorates HTTP responses from the API
    class Response < SimpleDelegator
      NotFound = Class.new(StandardError)
      HTTP_ERROR = {
        404 => NotFound
      }.freeze

      def initialize(http_response)
        super(http_response)
        @http_response = http_response
      end

      def successful?
        HTTP_ERROR.keys.include?(@http_response.code) ? false : true
      end

      def error
        HTTP_ERROR[@http_response.code]
      end
    end
  end
end
