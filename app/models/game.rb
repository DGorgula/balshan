class Game < ApplicationRecord
  attr_accessor :ktiv_male, :words
  belongs_to :word
end
