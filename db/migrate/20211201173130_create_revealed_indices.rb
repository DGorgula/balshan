class CreateRevealedIndices < ActiveRecord::Migration[6.1]
  def change
    create_table :revealed_indices do |t|
      t.references :game, null: false, foreign_key: true
      t.integer :index

      t.timestamps
    end
  end
end
