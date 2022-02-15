# frozen_string_literal: true

require 'set'
require 'parser/order_by_size'
require 'parser/file_validator'
require 'parser/content_validator'

module Parser
  # Maps logs to total and unique visits' amounts
  # check for file existence as well as valid ips
  class Mapper
    include OrderBySize
    include FileValidator
    include ContentValidator

    def transform_lines
      map_file_lines
      check_invalid_ipv4_ips
      order_by_size
    end

    def self.new_set_collection
      Set.new
    end

    private

    attr_reader :file_name, :logger, :regexp

    def initialize(file_name, logger, regexp)
      @logger = logger
      validate_file

      @file_name = file_name
      @regexp = regexp
    end

    def hash_data
      @hash_data ||= {}
    end

    def map_file_lines
      File.foreach(file_name) do |line|
        line_arr = line.chomp.split
        next unless valid_line?(line_arr)

        map_uniq_and_total_pages(line_arr)
      end
    end

    def map_uniq_and_total_pages(line_arr)
      page = line_arr[0]
      ip = line_arr[1]

      hash_data.key?(page) && (return add_new_ip(page, ip))

      add_new_page(hash_data, page, ip)
    end

    # { :page_url => [uniq_ips:set, all_ips:array] }
    def add_new_page(hash_data, page, ip)
      hash_data[page] = [(self.class.new_set_collection << ip), [ip]]
    end

    def add_new_ip(page, ip)
      [0, 1].each { |collection| hash_data[page][collection] << ip }
    end
  end
end
