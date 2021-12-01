class Word < ApplicationRecord
  validates :word, :presence => true
  validates :ktiv_male, :uniqueness => true
  # validates :letterCount, :presence => true :default => 5
  # validates :sessionCount, :presence => true
end
