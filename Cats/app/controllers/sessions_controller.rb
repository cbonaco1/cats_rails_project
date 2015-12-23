class SessionsController < ApplicationController

  def new

    render :new
  end

  def create
    user = User.find_by_credentials(params[:session][:username],params[:session][:password])

    if user
      user.reset_session_token!
      #assign user.session_token
      session[:session_token] = user.session_token
      redirect_to cats_url
    else
      #login failed
      render :new
    end

  end

  private

  def session_params
    params.require(:session).permit(:user_name, :password)
  end

end
