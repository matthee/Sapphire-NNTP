module NNTP
  module Client
    class Post
      def initialize(nntp)
        @nntp = nntp
        @fetched = false

      end

      def post_id=(post_id)
        if post_id != @post_id
          @post_id = post_id
          @fetched = false
        end
      end


      def fetched?
        @fetched
      end

      def raw
        ensure_fetch!
        @raw_post
      end

      private
      def ensure_fetch!
        unless fetched?
          raise ArgumentError unless @post_id
          @raw_post = @nntp.connection.query("ARTICLE #{@post_id}")
        end
      end
    end
  end
end
