require "rails_helper"

RSpec.describe 'Player', type: :model do
  let(:player) { Player.new('Joey') }
  let(:roy) { Player.new('Roy') }
  let(:go_fish) { GoFish.new(%w[player1 player2]) }
  let(:card) { PlayingCard.new('Queen', 'Spades') }
  let(:player2_card) { PlayingCard.new('4', 'Hearts') }
  let(:set) { [PlayingCard.new('Queen', 'Spades'), PlayingCard.new('Queen', 'Clubs'), PlayingCard.new('Queen', 'Hearts'), PlayingCard.new('Queen', 'Diamonds')]}
  let(:almost_set) { [PlayingCard.new('Queen', 'Clubs'), PlayingCard.new('Queen', 'Hearts'), PlayingCard.new('Queen', 'Diamonds')]}
  let(:deck_of_2) { [PlayingCard.new('Queen', 'Spades'), PlayingCard.new('4', 'Spades') ] }

  describe 'initialize' do
    it 'Should contain a name' do
      expect(player.name).to eq 'Joey'
    end

    it 'Should contain an array for players hand' do
      expect(player.hand).to eq []
    end

    it 'Should contain an array for the players sets' do
      expect(player.sets).to eq []
      player.sets.push(set)
      expect(player.sets.length).to eq 1
    end
  end

  describe 'hand_length' do
    it 'Should give the length of hand array' do
      go_fish.start
      expect(player.hand_length).to eq 0
      player.hand.push(card)
      expect(player.hand_length).to eq 1
    end
  end

  describe 'have_any?' do
    it 'Should search players hand for the card requested and return boolean' do
      player.hand.push(card)
      expect(player.have_any?('Queen')).to eq true
    end
    it 'Should search players hand for the card requested and return boolean' do
      player.hand.push(player2_card)
      expect(player.have_any?('Queen')).to eq false
    end
  end

  describe 'add_cards' do
    it 'adds a card to the players hand' do
      expect(player.hand).to eq []
      expect { player.add_cards(card) }.to change { player.hand_length }.by(1)
      expect(player.hand[0].rank).to match(/Queen/)
    end

    it 'checks for sets' do
      player.hand.push(almost_set)
      player.add_cards(card)
      expect(player.hand_length).to eq 0
    end
  end

  describe 'give_cards' do
    it 'Should remove card from current players hand and give to the other' do
      player.hand.push(card, player2_card)
      expect { player.give_cards(roy, 'Queen') }.to change { player.hand_length }.by(-1)
      player.hand.push(card)
      expect { player.give_cards(roy, 'Queen') }.to change { roy.hand_length }.by(1)
    end
  end

  describe 'check_for_sets' do
    it 'Checks for sets of four cards with matching rank and removes from hand' do
      player.hand.push(set)
      player.hand.flatten!
      expect { player.check_for_sets('Queen') }.to change { player.hand_length }.by(-4)
    end

    it 'Then moves them set of cards to the sets array' do
      player.hand.push(set)
      player.hand.flatten!
      expect { player.check_for_sets('Queen') }.to change { player.sets.length }.by(1)
    end
  end

  describe 'json conversion' do
    let(:card) { PlayingCard.new('Ace', 'Spades') }
    let(:deck) { Deck.new }
    let(:player) { Player.new('Player 1') }
    let(:player_json) { player.as_json }

    it 'returns a json object of player' do
      player.hand.push(deck)
      player.sets.push([card]).push([card])
      expect(player_json).to be_a Hash
    end

    it 'changes the json player object back into a player' do
      expect(Player.from_json(player_json)).to be_an_instance_of Player
    end
  end
end
