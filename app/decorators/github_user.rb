class GithubUser
  attr_reader :user

  delegate_missing_to :user

  def initialize(user)
    @user = user
  end

  def repos
    @repos ||= client.repos
  end

  def repos_names
    repos.map { |repo| "#{repo.owner.login}/#{repo.name}" }
  end

  def login
    @login ||= client.user.login
  end

  private

  def client
    @client ||= Octokit::Client.new(access_token: user.oauth_token)
  end
end
