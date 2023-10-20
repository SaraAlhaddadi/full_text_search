class AddSearchableColumnToJobs < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      ALTER TABLE jobs
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
        setweight(to_tsvector('english', coalesce(title, '')), 'A') ||
        setweight(to_tsvector('english', coalesce(skill,'')), 'B') ||
        setweight(to_tsvector('english', coalesce(sector,'')), 'C')
      ) STORED;
    SQL
  end

  def down
    remove_column :jobs, :searchable
  end
end
