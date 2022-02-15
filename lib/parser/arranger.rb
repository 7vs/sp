# frozen_string_literal: true

require 'parser/mapper'
require 'parser/gutenberg'
require 'parser/parrot'

module Parser
  TOOLS = {
    mapper: Mapper,
    printer: Gutenberg,
    logger: Parrot,
    regexp: ::Regexp
  }.freeze

  # Serves as the public interface to parse logs \
  # and print most visited and unique pages
  class Arranger
    def execute
      printer.print_most_visited_pages
      printer.print_most_uniq_visited_pages
    end

    private

    attr_reader :mapper, :printer

    def initialize(file_name)
      logger = TOOLS[:logger]
      regexp = TOOLS[:regexp]
      mapper = TOOLS[:mapper]
      printer = TOOLS[:printer]

      @mapper = mapper.new(file_name, logger, regexp)
      @printer = printer.new(parsed_uniq_and_total_pages)
    end

    def parsed_uniq_and_total_pages
      mapper.transform_lines
    end
  end
end
