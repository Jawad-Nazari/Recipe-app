class AddRecipeIdToFoods < ActiveRecord::Migration[7.0]
  def change
    add_reference :foods, :recipe, foreign_key: true, default: nil
  end
end
