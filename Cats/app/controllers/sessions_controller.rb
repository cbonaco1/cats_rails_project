class SessionsController < ApplicationController

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(params[:session][:username],params[:session][:password])

    if user
      sign_in!(user)
      redirect_to cats_url
    else
      #login failed
      render :new
    end

  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
    end
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:session).permit(:user_name, :password)
  end

end
