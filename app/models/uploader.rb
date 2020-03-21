class Uploader
  def initialize(post, client)
    @post = post
    @client = client
  end

  def call
    blob.create!
    tree.create!
    commit.create!
    post.update(commit_sha: commit.sha)
  end

  private

  attr_reader :post, :client

  def branch_head
    @branch_head ||= Github::BranchHead.new(client)
  end

  def blob
    @branch_head ||= Github::Blob.new(post.content, client)
  end

  def tree
    @branch_head ||= Github::Tree.new(post.filename, blob.sha, client, base_tree: branch_head.tree_sha)
  end

  def commit
    @branch_head ||= Github::Commit.new(post.commit_message, tree.sha, branch_head.sha, client)
  end
end
