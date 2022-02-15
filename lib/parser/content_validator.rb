# frozen_string_literal: true

module Parser
  # Checks for valid page paths and ips
  module ContentValidator
    private

    IPV4_REGEX =
      '(([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])\\.){3}([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])'

    IP_REGEX = '^\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}$'
    PATH_REGEX = '^\/.+'

    def invalid_ipv4_list
      @invalid_ipv4_list ||= []
    end

    def valid_line?(line)
      path = line.first
      ip = line.last

      return false unless path && ip

      invalid_ipv4_ips(ip)

      valid_path?(path) && valid_ip?(ip)
    end

    def check_invalid_ipv4_ips
      return if invalid_ipv4_list.empty?

      logger.print_invalid_ipv4_message
    end

    def regexp_for(string)
      regexp.new(string)
    end

    def valid_path?(path)
      path.match?(regexp_for(PATH_REGEX))
    end

    def valid_ip?(ip)
      ip.match?(regexp_for(IP_REGEX))
    end

    def valid_ipv4?(ip)
      ip.match?(regexp_for(IPV4_REGEX))
    end

    def invalid_ipv4_ips(ip)
      invalid_ipv4_list << ip unless valid_ipv4?(ip)
    end
  end
end
