class SessionsController < ApplicationController
  before_action :require_logged_out, only: [:new]

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if !user.nil? && user.authenticate(params[:session][:password])
      log_in(user)
      if remember?
        remember(user)
      else
        forget(user)
      end
      redirect_to root_url
    else
      respond_to do |format|
        format.html { render 'new', notice: 'Invalid email or password' }
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

  private

  def require_logged_out
    if logged_in?
      flash[:error] = 'You must log out before login'
      redirect_to root_url
    end
  end

end
