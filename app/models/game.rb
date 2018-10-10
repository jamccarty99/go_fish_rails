class Game < ApplicationRecord
  has_many :game_users
  has_many :users, through: :game_users

  # scope :pending, -> {where(game_size == game_user_count)}
  # scope :in_progress, -> {where(finished_at = nil)}
  def start

  end

end
