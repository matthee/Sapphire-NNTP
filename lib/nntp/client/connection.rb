module NNTP
  module Client
    class Connection
      def initialize(host, port, timeout: 5)
        @host = host
        @port = port
        @connected = false
        @closed = false
        @timeout = timeout
      end

      def ready?
        connected? && !closed?
      end

      def connected?
        @connected
      end

      def close
        cmd("QUIT", read: false)
        @connection.close
        @closed = true
      end

      def closed?
        @closed
      end

      def cmd(cmd, read: true)
        # puts "Sending command: #{cmd}"
        send_cmd_to_socket(cmd)
        NNTP::Client::Status.new(read_from_socket) if read
      end

      def query(cmd)
        # puts "Sending query: #{cmd}"
        send_cmd_to_socket(cmd)
        status = NNTP::Client::Status.new read_from_socket

        raise RuntimeError, status unless status.success?

        lines = ""
        while (line = read_from_socket).strip != "."
          if block_given?
            yield line
          else
            lines += line
          end
        end

        if block_given?
          status
        else
          lines
        end
      end

      private
      def open_connection
        Timeout::timeout(@timeout) do
          @connection = ::TCPSocket.new(@host, @port)
          @connection.gets
        end
        @connected = true
      end

      def send_cmd_to_socket(cmd)
        open_connection unless connected?
        raise RuntimeError, "NNTP connection already closed" if closed?
        Timeout::timeout(@timeout) do
          @connection.puts(cmd)
        end
      end

      def read_from_socket
        Timeout::timeout(@timeout) do
          @connection.gets
        end
      end
    end
  end
end
