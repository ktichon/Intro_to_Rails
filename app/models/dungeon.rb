class Dungeon < ApplicationRecord
  belongs_to :dungeon_purpose
  has_many :rooms;
  validates  :name, uniqueness: true
  validates  :name, :dungeon_purpose, presence: true
  validates  :width, :depth, :chambers, numericality: { only_integer: true }
end
