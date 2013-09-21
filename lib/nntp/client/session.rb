module NNTP
  module Client
    class Session
      attr_reader :group, :connection

      def self.start(host, port = 119)
        grabber = NNTP::Client::Session.new(host, port)

        if block_given?
          yield grabber
          grabber.finish!
        else
          grabber
        end
      end

      def initialize(host, port = 119)
        @connection = NNTP::Client::Connection.new(host, port)
      end

      def group(group_title)
        group = NNTP::Group.new(self)
        group.title = group_title
        group
      end

      def newsgroups
        groups = []
        @connection.query("LIST") do |group_str|
          group = NNTP::Client::Group.new(self)
          group.parse!(group_str)
          groups << group
        end
        groups
      end

      def posts(group)
        raise ArgumentError if group.nil?
        posts = []
        @connection.query("LISTGROUP #{group}") do |post_id|
          post = Post.new(self)
          post.post_id = post_id
          posts << post
        end
        posts
      end

      def post(post_id)
        post = Post.new(self)
        post.post_id = post_id
        post
      end

      def finish!
        @connection.close unless @connection.closed?
      end
    end
  end
end