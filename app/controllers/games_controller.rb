
class GamesController < ApplicationController
  # skip_before_action :require_authentication
  def show
    @game = Game.find(params[:id])
  end

  def index
  end
  def hello_world
    Pusher.trigger('my-channel', 'my-event', {
      message: 'hello world'
    })
  end
  def create
    # byebug
    game = Game.find_or_initialize_by(game_size: params[:game_size].to_i)
    game.save
    game.users << current_user unless game.users.include?(current_user)
    if game.game_size == game.users.size
      redirect_to game_path(game)
    else
      redirect_to game_path(game)
    end
  end

end
