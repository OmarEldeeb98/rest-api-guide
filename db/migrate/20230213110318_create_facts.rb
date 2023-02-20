class CreateFacts < ActiveRecord::Migration[7.0]
  def change
    create_table :facts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :fact

      t.timestamps
    end
  end
end
