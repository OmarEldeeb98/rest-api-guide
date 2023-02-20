class AddNameArToCategories < ActiveRecord::Migration[7.0]
  def change
    add_column :categories, :nameAr, :string
  end
end
