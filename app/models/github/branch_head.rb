module Github
  class BranchHead
    def initialize(client)
      @client = client
    end

    def sha
      @sha ||= ref.object.sha
    end

    def url
      @url ||= ref.object.url
    end

    def tree_sha
      @tree_sha ||= tree.sha
    end

    def tree_url
      @tree_url ||= tree.url
    end

    private

    attr_reader :client

    def tree
      @tree ||= commit.commit.tree
    end

    def commit
      client.commit(sha)
    end

    def ref
      @ref ||= client.ref
    end
  end
end