class GameUser < ApplicationRecord
  belongs_to :game, counter_cache: :game_user_count
  belongs_to :user
end
