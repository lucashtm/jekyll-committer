module Posts
  class Content
    FRONT_MATTER = '---'.freeze

    def initialize(post)
      @content = post.content
      @title = post.title
    end

    def call
      "#{header}#{content}"
    end

    private

    attr_reader :content, :title

    def header
      "#{FRONT_MATTER}\n#{header_params_stringfied}\n#{FRONT_MATTER}\n\n"
    end

    def header_params_stringfied
      header_params.map { |key, value| "#{key}: #{value}" }.join("\n")
    end

    def header_params
      {
        layout: 'post',
        title: title
      }
    end
  end
end