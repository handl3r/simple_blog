class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  # maybe want it to load cookies to load session before do anything in controller and then
  before_action :current_user
end
