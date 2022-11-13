# frozen_string_literal: true

# PaperWithCode API module
module PapMon
  # Entity module
  module Entity
    class Papers < SimpleDelegator
      attr_reader :papers
      def initialize(papers:)
        #array of paper entities
        #[paper1, paper2, paper3, ....]
        @papers = papers
      end
      def category_and_count
        papersCV=[]
        papersAI=[]
        papersLG=[]
        papersCL=[]
        papersNE=[]
        papersML=[]
        papersOTHER=[]
        @papers.each do |paper|
          case paper.primary_category
          when Value::Category::CV.name
            papersCV << paper
          when Value::Category::AI.name
            papersAI << paper
          when Value::Category::LG.name
            papersLG << paper
          when Value::Category::CL.name
            papersCL << paper
          when Value::Category::NE.name
            papersNE << paper
          when Value::Category::ML.name
            papersML << paper
          else
            papersOTHER << paper
          end
        end
        {"paperCV"=>papersCV, "nCV"=>papersCV.length,
        "paperAI"=>papersAI, "nAI"=>papersAI.length,
        "paperLG"=>papersLG, "nLG"=>papersLG.length,
        "paperCL"=>papersCL, "nCL"=>papersCL.length,
        "paperNE"=>papersNE, "nNE"=>papersNE.length,
        "paperML"=>papersML, "nML"=>papersML.length,
        "paperOTHER"=>papersOTHER, "nOTHER"=>papersOTHER.length}
      end
    end
  end
end