class HomeController < ApplicationController
  def index
    @users = User.all
    redirect_to '/login' unless current_user.present?
  end
end
