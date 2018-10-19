require_relative 'playing_card'

class CardDeck

  RANK = %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace]
  SUIT = %w[Clubs Diamonds Hearts Spades]

  def initialize(deck = CardDeck.create_deck)
    @deck = deck
  end

  def self.create_deck
    RANK.flat_map { |rank| SUIT.map { |suit| PlayingCard.new(rank, suit) } }
  end

  def deal
    deck.pop
  end

  def shuffle
    deck.shuffle!
  end

  def cards_left(deck = deck)
    deck.length
  end

  def empty?
    deck.empty?
  end

  def as_json
    { 'deck' => deck.map(&:as_json) }
  end

  def self.from_json(deck_json)
    CardDeck.new(PlayingCard.collection_from_data(deck_json['deck']))
  end

  private

  attr_accessor :deck

end
