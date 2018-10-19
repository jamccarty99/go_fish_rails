class Player
  attr_reader :name

  def initialize(name, hand = [], sets = [])
    @name = name
    @hand = hand
    @sets = sets
  end

  def hand_count
    hand.count
  end

  def sets_count
    sets.count
  end

  def add_cards(cards)
    cards.is_a?(Array) ? hand.concat(cards) : hand.push(cards)
  end

  def check_for_sets
    ranks_in_hand.each{ |rank| make_a_set(rank) if rank_count(rank) == 4 }
  end

  def has_any?(rank)
    ranks_in_hand.any?(rank)
  end

  def give_cards(rank)
    gift = hand.select{ |card| card.rank == rank }
    hand.reject!{ |card| card.rank == rank }
    gift
  end

  def empty?
    hand.empty?
  end

  def sets_value
    total_value = sets.map{ |rank| PlayingCard.value(rank) }.reduce(:+)
  end

  def highest_value
    value_array = sets.map{|rank| PlayingCard.value(rank)}
    value_array.max
  end

  def as_json
    {
      'name' => name,
      'hand' => hand.map(&:as_json),
      'sets' => sets
    }
  end

  def self.from_json(player_json)
    Player.new(
      player_json['name'],
      PlayingCard.collection_from_data(player_json['hand']),
      player_json['sets']
    )
  end

  def self.collection_from_data(data)
    data.map{ |player_data| Player.from_json(player_data)}
  end

  private

  attr_reader :sets
  attr_accessor :hand

  def ranks_in_hand
    hand.map(&:rank).uniq
  end

  def rank_count(rank)
    hand.map(&:rank).length
  end

  def make_a_set(rank)
    sets.push(rank)
    hand.reject!{ |card| card.rank == rank }
  end

  def sort_cards
    hand.sort! { |a, b| a.value <=> b.value }
  end


end
