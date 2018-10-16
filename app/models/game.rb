class Game < ApplicationRecord
  has_many :game_users
  has_many :users, through: :game_users

  # scope :pending, -> {where_not(game_size == game_user_count)} #started_at:nil
  # scope :in_progress, -> {where(finished_at:nil)} #where_not(started_at:nil).where(finished_at:nil)
  scope :pending, -> { where(started_at: nil) }
  scope :in_progress, -> { where.not(started_at: nil).where(finished_at: nil) }

  serialize :go_fish
  def start!
    return false unless player_count == users.count

    update(started_at: Time.zone.now)
  end

  def pending?
    game_size != users.size
    #started_at.blank?
  end

  def self.load(json)
    self.from_json(json)
  end

  def self.dump(obj)
    obj.as_json
  end

end
