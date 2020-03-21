module Github
  class Client

    delegate_missing_to :client

    def initialize(blog, user)
      @blog = blog
      @user = user
    end

    def ref
      client.ref(blog.repo, "heads/#{blog.branch}")
    end

    def commit(sha)
      client.commit(blog.repo, sha)
    end

    def create_blob(content, encoding)
      client.create_blob(blog.repo, content, encoding)
    end

    def create_tree(tree, base_tree:)
      client.create_tree(blog.repo, tree, base_tree: base_tree)
    end

    def create_commit(message, parents, tree)
      client.create_commit(blog.repo, message, tree, [parents])
    end

    def update_ref(sha)
      client.update_ref(blog.repo, "heads/#{blog.branch}", sha)
    end

    private

    attr_reader :blog, :user

    def client
      @client ||= Octokit::Client.new(access_token: user.oauth_token)
    end
  end
end
