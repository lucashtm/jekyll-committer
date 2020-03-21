module Github
  class Commit
    def initialize(message, parents, tree, client)
      @message = message
      @parents = parents
      @tree = tree
      @client = client
    end

    def create!
      @commit ||= client.create_commit(message, parents, tree)
    end

    def sha
      commit.sha
    end

    private

    attr_reader :message, :parents, :tree, :client, :commit
  end
end
