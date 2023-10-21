class Company < ApplicationRecord
  include PgSearch::Model
  multisearchable against: :name

  has_many :jobs
end
