require "rails_helper"

RSpec.describe 'CardDeck', type: :model do
  let(:deck) { Deck.new }
  let(:deck_of_2) { [PlayingCard.new('Queen', 'Spades'), PlayingCard.new('4', 'Spades')] }

  describe 'create_deck' do
    it 'Should have 52 cards when started' do
      test = Deck.create_deck
      expect(deck.cards_left(test)).to eq 52
    end
  end

  describe 'cards_left' do
    it 'Should return how many cards are left in the deck' do
      expect(deck.cards_left(deck_of_2)).to eq 2
    end
  end

  describe 'deal' do
    it 'Should take a card from the deck' do
      card = deck.deal(deck_of_2)
      expect(card.rank).to match(/Queen/)
      expect(card.suit).to match(/Spades/)
    end
  end

  describe 'shuffle!' do
    it 'Should shuffle the deck of cards' do
      expect(Deck.create_deck).to_not be_nil
      expect(deck.shuffled_deck).to_not eq deck.ordered_deck
    end
  end

  describe 'json conversion' do
    let(:deck) { Deck.new }
    let(:deck_json) { deck.as_json }
    let(:expanded_deck) { Deck.from_json(deck_json) }

    it 'returns a json object of deck' do
      expect(deck_json).to be_a Hash
    end

    it 'changes the json deck object back into a deck' do
      expect(expanded_deck).to be_an_instance_of Deck
    end
  end
end
