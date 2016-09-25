class AddDescriptionAndImageOnRecommendations < ActiveRecord::Migration[5.0]
  def change
    add_column :recommendations, :description, :text
    add_column :recommendations, :image, :string

    down do
      remove_column :recommendations, :description
      remove_column :recommendations, :image
    end
  end
end
