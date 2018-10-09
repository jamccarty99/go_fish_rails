class SessionsController < ApplicationController
  skip_before_action :require_authentication

  def new
  end

  def create
    @user = User.find_by(name: params[:session][:name])
    if @user && @user.authenticate(params[:session][:password])
      session[:current_user] = @user.id
      session[:user_name] = @user.name
      flash[:success] = "Login successful"
      redirect_to main_path
      # Log the user in and redirect to the user's show page.
    else
      flash[:danger] = 'Invalid name/password' # Not quite right!
      render 'new'
    end
  end

  def destroy
  end
end
