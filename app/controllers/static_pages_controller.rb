class StaticPagesController < ApplicationController
  skip_before_action :require_authentication
  def main
  end

  def settings
  end

  def size
  end

  def rule
  end

  def game
  end
end
