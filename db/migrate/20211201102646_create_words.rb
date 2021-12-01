class CreateWords < ActiveRecord::Migration[6.1]
  def change
    create_table :words do |t|
      t.string :word
      t.integer :letterCount
      t.integer :sessionCount

      t.timestamps
    end
  end
end
