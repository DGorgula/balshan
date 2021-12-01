class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.references :word, null: false, foreign_key: true
      t.integer :stepCount

      t.timestamps
    end
  end
end
