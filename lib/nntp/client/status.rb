module NNTP
  module Client
    class Status
      attr_reader :code, :message
      def initialize(string)
        parts = string.strip.split(/\s/, 2)
        @code = parts.first.to_i
        @message = parts.last
      end

      def success?
        code >= 200 && code < 300
      end

      def failed?
        !success?
      end

      def to_s
        "[#{@code}] #{@message}"
      end
    end
  end
end
