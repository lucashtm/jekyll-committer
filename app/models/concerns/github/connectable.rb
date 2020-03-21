module Github
  module Connectable
    extend ActiveSupport::Concern

    included do
      def client
        @client ||= Github::Client.new(blog, user)
      end
    end
  end
end
