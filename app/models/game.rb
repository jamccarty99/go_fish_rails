class Game < ApplicationRecord
  has_many :game_users
  has_many :users, through: :game_users

  scope :pending, -> { where(started_at: nil) }
  scope :in_progress, -> { where.not(started_at: nil).where(finished_at: nil) }

  # serialize :go_fish
  def start!
    return false unless player_count == users.count

    players = users.map(&:user.name)
    go_fish = GoFish.new(players)
    update(data: go_fish.as_json, started_at: Time.zone.now)
  end

  def create_game_if_possible!
    return unless data.nil?

    update!(data: GoFish.new.as_json)
  end

  def create_game_user!(current_user)
    go_fish.add_player(current_user.name)
    users << current_user unless users.include?(current_user)
    update!(data: go_fish.as_json)
  end

  def play_round!
    go_fish.play_round!
    update!(data: go_fish.as_json)
  end

  def pending?
    game_size != users.size
  end

  def current_player
    go_fish.current_player
  end

  def go_fish
    @go_fish ||= GoFish.from_json(data)
  end
  # def self.load(json)
  #   self.from_json(json)
  # end
  #
  # def self.dump(obj)
  #   obj.as_json
  # end

end
