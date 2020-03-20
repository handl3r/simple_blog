module RequireAction
  include ActiveSupport::Concern
  include SessionsHelper

  included do
    before_action :require_logged_out, only: [:new]
  end

  private

  def require_logged_out
    if logged_in?
      flash[:error] = 'You must log out before login'
      redirect_to root_url
    end
  end

end
