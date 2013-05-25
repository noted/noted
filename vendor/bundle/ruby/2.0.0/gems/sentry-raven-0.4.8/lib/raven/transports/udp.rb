require 'socket'

require 'raven/transports'
require 'raven/error'

module Raven

  module Transports

    class UDP < Transport

      def send(auth_header, data, options = {})
        conn.send "#{auth_header}\n\n#{data}", 0
      end

    private

      def conn
        @conn ||= begin
          sock = UDPSocket.new
          sock.connect(self.configuration.host, self.configuration.port)
          sock
        end
      end

      def verify_configuration
        super
        raise Error.new('No port specified') unless self.configuration.port
      end

    end

  end

end
