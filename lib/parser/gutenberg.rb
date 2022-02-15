# frozen_string_literal: true

module Parser
  # Print most visited and unique page totals
  class Gutenberg
    def print_most_visited_pages
      return print_nothing_parsed unless total_pages_to_string.any?

      print "\n--- Most Visited Pages: ---\n"
      print total_pages_to_string.join("\n")
    end

    def print_most_uniq_visited_pages
      return print_nothing_parsed unless uniq_pages_to_string.any?

      print "\n--- Most Unique Visited Pages: ---\n"
      print uniq_pages_to_string.join("\n")
    end

    def print_nothing_parsed
      print "--- There was not a valid record to parse --' \n"
    end

    private

    attr_reader :total_pages, :uniq_pages

    def initialize(args)
      @total_pages = args.first
      @uniq_pages = args.last
    end

    def total_pages_to_string
      total_pages.map { |page| page.join(': ') }
    end

    def uniq_pages_to_string
      uniq_pages.map { |page| page.join(': ') }
    end
  end
end
