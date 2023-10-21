class Job < ApplicationRecord
  include PgSearch::Model

  multisearchable against: %i[title sector skill]

  # Job.search_title('Pharmacist')
  pg_search_scope :search_title, against: :title
  # Job.search_skill('Technical').limit(2)
  pg_search_scope :search_skill, against: :skill
  # Job.search_by('country', 'Yemen').limit(2)
  pg_search_scope :search_by, lambda { |attr, query|
    raise ArgumentError("#{attr} is not correct column") unless self.column_names.include?(attr)
    {
      against: attr,
      query: query
    }
  }

  # Searching through associations
  # Job.company_search('Altenwerth').last.company
  pg_search_scope :company_search, associated_against: {
    company: [:name, :description]
  }

  # Job.title_starts_with('de').limit(5)
  pg_search_scope :title_starts_with,
                  against: :title,
                  using: {
                    tsearch: { prefix: true }
                  }

  # Job.support_title_negation('designer !Marketing').limit(5)
  pg_search_scope :support_title_negation,
                  against: :title,
                  using: {
                    tsearch: {negation: true}
                  }

  # Job.search_job('Pharmacist Education')
  pg_search_scope :search_job,
                  against: %i[title sector skill],
                  using: { tsearch: { dictionary: 'english' } }

  # this will not use index => Job.search_job_score('Design').explain
  pg_search_scope :search_job_score,
                  against: { title: 'A', skill: 'B', sector: 'C' },
                  using: { tsearch: { dictionary: 'english' } }

  # this will use index =>Job.search_job_column('Design').explain
  pg_search_scope :search_job_column,
                  against: { title: 'A', skill: 'B', sector: 'C' },
                  using: { tsearch: { dictionary: 'english' , tsvector_column: 'searchable' } }

  pg_search_scope :search_and_break_ties_by_latest_update,
                against: [:title, :skill],
                order_within_rank: "jobs.updated_at DESC"

  belongs_to :company
end
