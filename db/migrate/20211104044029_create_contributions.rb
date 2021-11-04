class CreateContributions < ActiveRecord::Migration[5.2]
  def change
    create_table :contributions do |t|
      t.integer :customer_id
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
