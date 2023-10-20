class Job < ApplicationRecord
  include PgSearch::Model
  # Job.search_title('Pharmacist')
  pg_search_scope :search_title, against: :title

  # Job.search_job('Pharmacist Education')
  pg_search_scope :search_job,
                  against: %i[title sector skill],
                  using: { tsearch: { dictionary: 'english' } }

  pg_search_scope :search_job_score,
                  against: { title: 'A', skill: 'B', sector: 'C' },
                  using: { tsearch: { dictionary: 'english' } }
end
