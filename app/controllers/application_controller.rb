class ApplicationController < ActionController::Base
  helper_method :github_user

  def github_user
    @github_user ||= GithubUser.new(current_user)
  end
end
