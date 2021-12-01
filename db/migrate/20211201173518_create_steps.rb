class CreateSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|
      t.references :game, null: false, foreign_key: true
      t.string :stepWord
      t.integer :inPlaceLetterCount
      t.integer :existLetterCount

      t.timestamps
    end
  end
end
