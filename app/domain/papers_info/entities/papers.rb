# frozen_string_literal: true

# PaperWithCode API module
module PapMon
  # Entity module
  module Entity
    # Papers Entity
    class Papers < SimpleDelegator
      attr_reader :papers

      def initialize(papers:)
        # array of paper entities
        # [paper1, paper2, paper3, ....]
        super(papers)
        @papers = papers
      end

      def category_and_count
        papers_cv = []
        papers_ai = []
        papers_lg = []
        papers_cl = []
        papers_ne = []
        papers_ml = []
        papers_other = []
        @papers.each do |paper|
          case paper.primary_category
          when Value::Category::CV.name
            papers_cv << paper
          when Value::Category::AI.name
            papers_ai << paper
          when Value::Category::LG.name
            papers_lg << paper
          when Value::Category::CL.name
            papers_cl << paper
          when Value::Category::NE.name
            papers_ne << paper
          when Value::Category::ML.name
            papers_ml << paper
          else
            papers_other << paper
          end
        end
        { 'paperCV' => papers_cv, 'nCV' => papers_cv.length,
          'paperAI' => papers_ai, 'nAI' => papers_ai.length,
          'paperLG' => papers_lg, 'nLG' => papers_lg.length,
          'paperCL' => papers_cl, 'nCL' => papers_cl.length,
          'paperNE' => papers_ne, 'nNE' => papers_ne.length,
          'paperML' => papers_ml, 'nML' => papers_ml.length,
          'paperOTHER' => papers_other, 'nOTHER' => papers_other.length }
      end
    end
  end
end
