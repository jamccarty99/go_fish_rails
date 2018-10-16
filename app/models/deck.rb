require_relative 'playing_card'

class Deck
  attr_reader :deck

  RANK = %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace]
  SUIT = %w[Clubs Diamonds Hearts Spades]

  def initialize(deck: Deck.create_deck)
    @deck = deck
  end

  def self.create_deck
    RANK.flat_map { |rank| SUIT.map { |suit| PlayingCard.new(rank, suit) } }
  end

  def deal(deck = @deck)
    deck.shift
  end

  def shuffle
    deck.shuffle
  end

  def cards_left(deck)
    deck.length
  end

  def ordered_deck
    deck.collect(&:to_s)
  end

  def shuffled_deck
    shuffled = deck.shuffle
    shuffled.collect(&:to_s)
  end

  def as_json
    { 'deck' => deck.map(&:as_json) }
  end

  def self.from_json(deck_json)
    Deck.new(deck: PlayingCard.collection_from_data(deck_json['deck']))
  end

end
