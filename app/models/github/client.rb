module Github
  class Client
    def initialize(repo, branch, oauth_token: nil)
      @repo = repo
      @branch = branch
      @oauth_token = oauth_token
    end

    def ref
      client.ref(repo, "heads/#{branch}")
    end

    def commit(sha)
      client.commit(repo, sha)
    end

    def create_blob(content, encoding)
      client.create_blob(repo, content, encoding)
    end

    def create_tree(tree, base_tree:)
      client.create_tree(repo, tree, base_tree: base_tree)
    end

    def create_commit(message, parents, tree)
      client.create_commit(repo, message, tree, [parents])
    end

    private

    attr_reader :repo, :branch, :oauth_token

    def client
      return @client ||= Octokit::Client.new(access_token: oauth_token) if oauth_token.present?
      @client ||= Octokit::Client.new
    end
  end
end
