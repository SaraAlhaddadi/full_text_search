class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :country
      t.string :title
      t.string :gender
      t.string :skill
      t.string :sector
      t.string :company
      t.decimal :salary

      t.timestamps
    end
  end
end
