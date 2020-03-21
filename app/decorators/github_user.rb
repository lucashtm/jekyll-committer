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
    repos.map(&:name)
  end

  def ref
    client.ref(repo, branch)
  end

  def login
    @login ||= client.user.login
  end

  def commit
    @commit ||= client.commit(repo, sha)
  end

  def create_blob(content, encoding = 'utf-8')
    # Octokit.create_blob(repo, content, encoding)
    client.create_blob(repo, content, encoding)
  end

  def client
    @client ||= Octokit::Client.new(access_token: user.oauth_token)
  end

  def create_tree
    client.create_tree(repo, tree, base_tree: tree_sha)
  end

  def tree
    [{
      'path': 'aaa.txt',
      'mode': '100644',
      'type': 'blob',
      'sha': blob_sha
    }]
  end

  def create_commit
    client.create_commit(repo, 'Commit from api', new_tree_sha, [sha])
  end

  def update_ref
    client.update_ref(repo, branch, new_commit_sha)
  end

  private

  def new_commit_sha
    "370f4c7cd502a1087c06eaacac70c8d558fa4138"
  end

  def blob_sha
    "fd51d160109452800e29894576e4fab897f6cd3d"
  end

  def new_tree_sha
    '6edda9fc444d70a3d5017c4906f910a778f23a1a'
  end

  def tree_sha
    @tree_sha ||= commit.commit.tree.sha
  end

  def tree_url
    @tree_url ||= commit.commit.tree.url
  end

  def sha
    @sha ||= ref.object.sha
  end

  def repo
    "#{login}/api-test"
  end

  def branch
    'heads/master'
  end
end
