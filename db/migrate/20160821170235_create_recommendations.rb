class CreateRecommendations < ActiveRecord::Migration[5.0]
  def change
    create_table :recommendations do |t|
      t.string :address
      t.string :title
      t.string :tag
      t.string :recommender
      t.string :recorder
      t.string :type

      t.timestamps
    end
  end
end
