require "rails_helper"

RSpec.describe Game, type: :model do
  describe '.pending' do
    it 'returns games not yet started' do
      done_game = create(:game, :finished)
      in_progress = create(:game, :started)
      pending = create(:game)

      expect(Game.pending).to eq [ pending ]
    end
  end

  describe '.in_progress' do
    it 'returns cames still in progress' do
      done_game = create(:game, :finished)
      in_progress = create(:game, :started)
      pending = create(:game)

      expect(Game.in_progress).to eq [ in_progress ]
    end
  end
end
