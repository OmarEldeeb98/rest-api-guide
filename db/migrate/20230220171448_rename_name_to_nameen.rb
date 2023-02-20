class RenameNameToNameen < ActiveRecord::Migration[7.0]
  def change
    rename_column(:categories, :name, :name_en)
    rename_column(:categories, :nameAr, :name_ar)
  end
end
