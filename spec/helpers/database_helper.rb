# frozen_string_literal: true

module DatabaseHelper
  def self.wipe_database
    PapMon::App.DB.run('PRAGMA foreign_keys = OFF')
    PapMon::Database::PaperOrm.map(&:destroy)
    PapMon::Database::DatasetOrm.map(&:destroy)
    PapMon::Database::RepositoryOrm.map(&:destroy)
    PapMon::App.DB.run('PRAGMA foreign_keys = ON')
  end
end
