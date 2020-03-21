module Jekyll
  class FilenameGenerator
    ROOT_DIRECTORY = '_posts'

    def initialize(title)
      @title = title
    end

    def call
      "#{ROOT_DIRECTORY}/#{time.year}-#{time.month}-#{time.day}-#{title.downcase.tr(' ', '-')}.md"
    end

    private

    attr_reader :title

    def time
      @time ||= Time.current
    end
  end
end
