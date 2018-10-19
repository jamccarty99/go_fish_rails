# require "rails_helper"
#
# RSpec.describe GoFish, type: :model do
#   let(:player1_card) { PlayingCard.new('Queen', 'Spades') }
#   let(:player2_card) { PlayingCard.new('4', 'Hearts') }
#   let(:go_fish) { GoFish.new(%w[player1 player2]) }
#   let(:go_fish_of_5) { GoFish.new(%w[player1 player2 player3 player4 player5]) }
#   let(:deck_of_2) { [PlayingCard.new('Queen', 'Spades'), PlayingCard.new('4', 'Spades')] }
#   let(:deck_of_1) { [PlayingCard.new('4', 'Hearts')] }
#   let(:set) { [PlayingCard.new('Queen', 'Spades'), PlayingCard.new('Queen', 'Clubs'), PlayingCard.new('Queen', 'Hearts'), PlayingCard.new('Queen', 'Diamonds')] }
#   let(:player2) { Player.new('player2')}
#
#   describe 'start' do
#     it 'Should deal 5 cards to each player in a 4+ player go_fish' do
#       go_fish_of_5.start
#       expect(go_fish_of_5.players[0].hand_length).to eq 5
#       expect(go_fish_of_5.players[0].hand_length).not_to eq 26
#     end
#
#     it 'Should deal 7 cards to each player in a 2 or 3 player go_fish' do
#       go_fish.start
#       expect(go_fish.players[0].hand_length).to eq 7
#       expect(go_fish.players[0].hand_length).not_to eq 26
#     end
#
#     it 'Should create instances of each player' do
#       go_fish_of_5.start
#       expect(go_fish_of_5.players[4]).to be_instance_of(Player)
#     end
#   end
#
#   describe 'deal' do
#     it 'Should take a card from the deck' do
#       card = go_fish.deal(deck_of_2)
#       expect(card.rank).to match(/Queen/)
#       expect(card.suit).to match(/Spades/)
#     end
#   end
#
#   describe 'play_round' do
#     it 'should play a round of Go-Fish and display the current go_fish details' do
#       go_fish.start
#       go_fish.next_players_turn
#       expect(go_fish.play_round('Ace', player2)).to match(/player1 has/)
#       expect(go_fish.play_round('Ace', player2)).not_to match(/player1 has 26 cards in hand/)
#     end
#   end
#
#   describe 'play_turn' do
#     it 'should play the current_players turn' do
#       go_fish.start
#       go_fish.next_players_turn
#       expect(go_fish.play_turn('5', player2)).to eq('There are no more fish to catch:(').or match(/went fishing!/)
#     end
#   end
#
#   describe 'request_cards' do
#     it 'Should give cards to current_player if player asked has at least one' do
#       go_fish.start
#       go_fish.next_players_turn
#       empty_hand
#       go_fish.players[1].hand.push(player1_card)
#       # expect(go_fish.request_cards("Queen", go_fish.players[1])).to match /received/
#       expect { go_fish.request_cards('Queen', go_fish.players[1]) }.to change { go_fish.players[0].hand_length }.by(1)
#     end
#
#     it 'Should display a message if the player asked does not have the card' do
#       go_fish.start
#       go_fish.next_players_turn
#       empty_hand
#       expect(go_fish.request_cards('Queen', go_fish.players[1])).to match(/Go Fish!/)
#     end
#
#     def empty_hand
#       go_fish.players[1].hand.shift until go_fish.players[1].hand == []
#     end
#   end
#
#   describe 'go_fish' do
#     it 'Should deal a card to current_player if there are cards in the deck' do
#       go_fish.start
#       go_fish.next_players_turn
#       expect { go_fish.go_fish }.to change { go_fish.players[0].hand_length }.by(1)
#     end
#
#     it 'Should send the player a message if the deck is empty' do
#       go_fish.start
#       go_fish.next_players_turn
#       go_fish.send(:deck=, [])
#       expect(go_fish.go_fish).to match(/There are no more fish to catch/)
#     end
#   end
#
#   describe 'next_players_turn' do
#     it 'Should set current_player to the next players turn' do
#       go_fish_of_5.start
#       go_fish_of_5.next_players_turn
#       expect(go_fish_of_5.next_players_turn).not_to eq go_fish_of_5.players[0]
#       expect(go_fish_of_5.next_players_turn).to eq go_fish_of_5.players[2]
#       expect(go_fish_of_5.next_players_turn).to eq go_fish_of_5.players[3]
#     end
#   end
#
#   describe 'sets_total' do
#     it 'should count the total number of sets between all players in go_fish' do
#       go_fish.start
#       go_fish.players[0].sets.push(set)
#       expect(go_fish.sets_total).to eq 1
#     end
#   end
#
#   describe 'most_sets' do
#     it 'Should return the player with the most sets' do
#       go_fish.start
#       go_fish.players[1].sets.push(set)
#       expect(go_fish.most_sets).not_to eq go_fish.players[0]
#       expect(go_fish.most_sets).to eq go_fish.players[1]
#     end
#   end
#   describe 'winner' do
#     it 'should declare the winner of the go_fish' do
#       go_fish.start
#       13.times do
#         go_fish.players[1].sets.push(set)
#       end
#       expect(go_fish.winner).to match(/Winner/)
#     end
#   end
# end
