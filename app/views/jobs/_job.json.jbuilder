json.extract! job, :id, :country, :title, :gender, :skill, :sector, :company, :salary, :posted_at, :created_at, :updated_at
json.url job_url(job, format: :json)
