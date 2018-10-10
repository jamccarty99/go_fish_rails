require "rails_helper"

RSpec.describe 'PlayingCard' do
  let(:card) { PlayingCard.new('Ace', 'Spades') }

  it 'returns rank' do
    expect(card.rank).to eq 'Ace'
  end

  it 'returns suit' do
    expect(card.suit).to eq 'Spades'
  end

  it 'returns value' do
    expect(card.value).to eq 13
  end
end
