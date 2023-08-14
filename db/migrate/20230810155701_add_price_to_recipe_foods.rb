class AddPriceToRecipeFoods < ActiveRecord::Migration[6.0]
  def change
    add_column :recipe_foods, :price, :decimal, default: 0.0
  end
end
