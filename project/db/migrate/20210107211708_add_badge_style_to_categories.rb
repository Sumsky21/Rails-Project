class AddBadgeStyleToCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :badge_style, :string
  end
end
