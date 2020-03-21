class Uploader
  def initialize(post, client)
    @post = post
    @client = client
  end

  def call
    blob.create!
    tree.create!
    commit.create!
    set_head
    post.update(commit_sha: commit.sha)
  end

  private

  attr_reader :post, :client

  def branch_head
    @branch_head ||= Github::BranchHead.new(client)
  end

  def blob
    @blob ||= Github::Blob.new(post.content, client)
  end

  def tree
    @tree ||= Github::Tree.new(post.filename, blob.sha, client, base_tree: branch_head.tree_sha)
  end

  def commit
    @commit ||= Github::Commit.new(post.commit_message, branch_head.sha, tree.sha, client)
  end

  def set_head
    client.update_ref(commit.sha)
  end
end
