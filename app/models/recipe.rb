class Recipe < ApplicationRecord
  has_many :recipe_foods, class_name: 'RecipeFood', foreign_key: 'recipe_id', dependent: :destroy
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  has_many :foods, dependent: :destroy

  validates :name, presence: true, length: { in: 2..200 }
  validates :description, presence: true
  validates :preparation_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :cooking_time, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def toggle_public
    update(public: !public)
  end

  def add_to_shopping_list
    update(add_to_shopping_list: !add_to_shopping_list)
  end
end
