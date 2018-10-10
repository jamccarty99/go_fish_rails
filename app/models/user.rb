class User < ApplicationRecord
  has_many :game_users
  has_many :games, through: :game_users

  validates :name,  presence: true, length: { maximum: 50 }, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }#, confirmation: true
  # validates :password_confirmation, presence: true
end
