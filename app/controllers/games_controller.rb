class GamesController < ApplicationController
  skip_before_action :require_authentication
  def show
    # if @game && @game.
    # else
    #   redirect_to '/waiting'
  end

  def index
  end
end
