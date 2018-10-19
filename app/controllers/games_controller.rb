
class GamesController < ApplicationController
  # skip_before_action :require_authentication
  def show
    game = Game.find(params[:id])
    render :show, locals:{game: game, current_user: current_user, current_player: game.current_player }
  end

  def index
  end

  def create
    # byebug
    game = Game.find_or_initialize_by(game_size: params[:game_size].to_i)
    # game.save
    game.create_game_if_possible!
    game.create_game_user!(current_user)
    redirect_to game_path(game)
    # game.users << current_user unless game.users.include?(current_user)
    # if game.game_size == game.users.size
    #   redirect_to game_path(game)
    # else
    #   redirect_to game_path(game)
    # end
  end

end
