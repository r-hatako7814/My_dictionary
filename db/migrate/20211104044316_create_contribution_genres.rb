class CreateContributionGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :contribution_genres do |t|
      t.integer :genre_id
      t.string :contribution_id

      t.timestamps
    end
  end
end
