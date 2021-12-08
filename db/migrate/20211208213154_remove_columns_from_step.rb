class RemoveColumnsFromStep < ActiveRecord::Migration[6.1]
  def change
    remove_column :steps, :existLetterCount, :integer
    remove_column :steps, :inPlaceLetterCount, :integer
  end
end
