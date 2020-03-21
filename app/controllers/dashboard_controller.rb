class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = GithubUser.new(current_user)
    
    binding.pry
    
  end
end
