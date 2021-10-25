class Dungeon < ApplicationRecord
  has_many :adventure_in_dungeons
  has_many :adventures, through: :adventure_in_dungeons
  belongs_to :dungeon_purpose
  has_many :rooms;
  validates  :name, uniqueness: true
  validates  :name, :dungeon_purpose, presence: true
  validates  :width, :depth, :chambers, numericality: { only_integer: true }
end
