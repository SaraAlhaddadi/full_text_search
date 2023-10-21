class AddCompanyIdToJobs < ActiveRecord::Migration[7.0]
  def change
    add_reference :jobs, :company, foreign_key: true, index: true
    remove_column :jobs, :company, :string
  end
end
