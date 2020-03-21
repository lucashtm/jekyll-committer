module Github
  class Tree
    DEFAULT_MODE = '100644'.freeze
    DEFAULT_TYPE = 'blob'.freeze

    def initialize(path, blob_sha, client, tree_attrs)
      @path = path
      @blob_sha = blob_sha
      @client = client
      @tree_attrs = tree_attrs
      @mode = tree_attrs[:mode]
      @type = tree_attrs[:type]
      @base_tree = tree_attrs[:base_tree]
    end

    def create!
      @tree ||= client.create_tree(tree_attrs, base_tree: base_tree)
    end

    def sha
      tree.sha
    end

    private

    attr_reader :tree, :path, :blob_sha, :client, :base_tree

    def tree_attrs
      [{
        'path': 'aaa.txt',
        'mode': mode,
        'type': type,
        'sha': blob_sha
      }]
    end

    def mode
      @mode || DEFAULT_MODE
    end

    def type
      @type || DEFAULT_TYPE
    end
  end
end
