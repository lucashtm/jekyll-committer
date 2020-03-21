module Jekyll
  class FilenameGenerator
    def initialize(title)
      @title = title
    end

    def call
      "#{time.year}-#{time.month}-#{time.day}-#{title.downcase.tr(' ', '-')}.md"
    end

    private

    attr_reader :title

    def time
      @time ||= Time.current
    end
  end
end
