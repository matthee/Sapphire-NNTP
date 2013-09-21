module NNTP
  module Client
    class Group
      attr_accessor :title

      def initialize(nntp)
        @nntp = nntp
      end

      def parse!(string)
        @title = string.strip.split(/\s/).first
      end

      def posts
        @nntp.posts(self.title)
      end
    end
  end
end
