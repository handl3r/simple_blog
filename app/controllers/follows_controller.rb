# frozen_string_literal: true

class FollowsController < ApplicationController
  # before action must login
  def create
    @user = User.find(params[:followed_user_id])
    current_user.follow(@user)
    respond_to do |format|
      format.html { redirect_to @user }
    end
  end

  def destroy
    follow = Follow.find(params[:id])
    user = follow.followed_user
    follow.destroy
    respond_to do |format|
      format.html { redirect_to user, notice: 'Unfollow successfully' }
    end
  end
end
