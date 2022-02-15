# frozen_string_literal: true

module Parser
  # Order most visited and unique page totals
  module OrderBySize
    private

    def order_by_size
      [sorted_most_visited_pages, sorted_most_uniq_visited_pages]
    end

    def sorted_most_visited_pages
      most_visited_pages.sort_by { |page| -page.last }
    end

    def sorted_most_uniq_visited_pages
      most_uniq_visited_pages.sort_by { |page| -page.last }
    end

    def sized_hash_data
      @sized_hash_data = calculate_visits_size
    end

    def most_visited_pages
      sized_hash_data.dup.each { |ips| ips.last.delete_at(0) }.map(&:flatten)
    end

    def most_uniq_visited_pages
      sized_hash_data.each { |ips| ips.last.delete_at(1) }.map(&:flatten)
    end

    def calculate_visits_size
      new_hash = {}

      hash_data.each do |key, value|
        new_hash[key] = value.map(&:size)
      end

      new_hash
    end
  end
end
