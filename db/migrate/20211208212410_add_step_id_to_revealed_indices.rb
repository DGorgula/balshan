class AddStepIdToRevealedIndices < ActiveRecord::Migration[6.1]
  def change
    add_reference :revealed_indices, :step, null: false, foreign_key: true
  end
end
