class UsersController < ApplicationController
  skip_before_action :require_authentication, only: [:new, :create]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def index
  end
  
  def create
    @user = User.new(user_params)
    # byebug
    if @user.save
      session[:current_user] = @user.id
      flash[:success] = "Welcome to the Go Fish!"
      redirect_to sessions_path, notice: 'Logged in successfully'
    else
      flash[:danger] = 'Please correctly fill in the fields' # Not quite right!
      # flash[:danger] = 'Invalid name/password combination' # Not quite right!
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
