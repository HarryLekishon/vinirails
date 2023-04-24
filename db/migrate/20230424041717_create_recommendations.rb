class CreateRecommendations < ActiveRecord::Migration[7.0]
  def change
    create_table :recommendations do |t|
      t.string :title
      t.text :overview
      t.date :release_date

      t.timestamps
    end
  end
end
