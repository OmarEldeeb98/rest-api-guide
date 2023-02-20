class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    def self.up
      rename_column :categories, :category, :name
    end
  end
end
