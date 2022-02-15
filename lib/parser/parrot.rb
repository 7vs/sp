# frozen_string_literal: true

module Parser
  # User Friendly error logger
  module Parrot
    class << self
      def print_error_message_and_exit(error)
        print "--- An error has been raised and the program won't run. ---\n"
        print "Error message: #{error.message}\n"
        exit
      end

      def print_invalid_ipv4_message
        print "--- We are still parsing invalid Ipv4s. ---\n"
        print "--- Ignore this message if this behaviour is expected. ---\n"
        print "--- Please check the logs source otherwise. ---\n"
      end
    end
  end
end
