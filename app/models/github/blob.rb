module Github
  class Blob
    DEFAULT_ENCODING = 'utf-8'.freeze

    def initialize(content, client, encoding: DEFAULT_ENCODING)
      @content = content
      @client = client
      @encoding = encoding
    end

    def create!
      @blob ||= client.create_blob(content, encoding)
    end

    def sha
      blob
    end

    private

    attr_reader :blob, :content, :client, :encoding
  end
end
