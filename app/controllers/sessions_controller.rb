class SessionsController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        redirect_back_or user
      else
<<<<<<< HEAD
        message  = "Account not activated. "
        message += "Check your email for the activation link."
=======
        message  = t ".Account not activated. "
        message += t ".Check your email for the activation link."
>>>>>>> password-reset
        flash[:warning] = message
        redirect_to root_url
      end
      else
        flash.now[:danger] = t ".Invalid email/password combination"
        render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
