class Player
  attr_accessor :hand, :sets
  attr_reader   :name

  def initialize(name, hand = [], sets = [])
    @name = name
    @hand = []
    @sets = []
  end

  def hand_length
    hand.length
  end

  def sets_count
    sets.length
  end

  def have_any?(rank)
    hand.flatten!
    hand.sort! { |a, b| a.rank <=> b.rank }
    hand.any? { |card| card.rank == rank }
  end

  def add_cards(*cards)
    single_rank = cards[0].rank
    self.hand.push(cards)
    check_for_sets(single_rank)
  end

  def check_for_sets(card_rank)
    if have_any?(card_rank)
      matching_cards = hand.select { |card| card.rank == card_rank }
      if matching_cards.length == 4
        hand.reject! { |card| card.rank == card_rank }
        sets.push(matching_cards)
      end
    end
  end

  def give_cards(receiver, rank)
    cards = hand.select { |card| card.rank == rank }
    hand.reject! { |card| card.rank == rank }
    receiver.add_cards(*cards)
    @message = "#{receiver.name} received #{cards.length} #{rank}/s!"
  end

  def as_json
    {
      'name' => name,
      'hand' => hand.map(&:as_json),
      'sets' => sets.map{ |set| set.map(&:as_json) }
    }
  end

  def self.from_json(player_json)
    Player.new(
      player_json['name'],
      hand: PlayingCard.collection_from_data(player_json['hand']),
      sets: player_json['sets'].map{ |set|
        PlayingCard.collection_from_data(set)
      }
    )
  end
end
