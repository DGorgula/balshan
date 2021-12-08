class CreateMismatchedIndices < ActiveRecord::Migration[6.1]
  def change
    create_table :mismatched_indices do |t|
      t.references :game, null: false, foreign_key: true
      t.references :step, null: false, foreign_key: true
      t.integer :index

      t.timestamps
    end
  end
end
