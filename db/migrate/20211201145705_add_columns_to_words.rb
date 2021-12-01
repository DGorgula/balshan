class AddColumnsToWords < ActiveRecord::Migration[6.1]
  def change
    add_column :words, :definition, :string
    add_column :words, :ktiv_male, :string
  end
end
