# frozen_string_literal: true

require 'rspec'
require 'parser/gutenberg'

describe Parser::Gutenberg do
  context 'given an input including most visited and unique visits array' do
    subject do
      described_class.new([most_visited, unique])
    end

    let(:most_visited) do
      [['/home', 19], ['/about', 19], ['/help_page/1', 18], ['/about/2', 17]]
    end

    let(:unique) do
      [['/home', 14], ['/about', 13], ['/help_page/1', 12], ['/about/2', 12]]
    end

    let(:most_visited_message) do
      %(--- Most Visited Pages: ---\n/home: 19\n/about: 19\n/help_page/1: 18\n/about/2: 17)
    end

    let(:unique_message) do
      %(--- Most Unique Visited Pages: ---\n/home: 14\n/about: 13\n/help_page/1: 12\n/about/2: 12)
    end

    let(:print_nothing_parsed) { '--- There was not a valid record to parse --' }

    context 'when only most visited values are passed' do
      let(:unique) { [] }

      it 'print most visited pages' do
        expect { subject.print_most_visited_pages }.to output(a_string_including(most_visited_message)).to_stdout

        expect { subject.print_most_uniq_visited_pages }.to output(
          a_string_including(print_nothing_parsed)
        ).to_stdout
      end
    end

    context 'when only most visited values are passed' do
      let(:most_visited) { [] }

      it 'print unique pages' do
        expect { subject.print_most_uniq_visited_pages }.to output(a_string_including(unique_message)).to_stdout

        expect { subject.print_most_visited_pages }.to output(
          a_string_including(print_nothing_parsed)
        ).to_stdout
      end
    end

    context 'given an empty array input' do
      let(:most_visited) { [] }
      let(:unique) { [] }
      let(:most_visited_message) { '--- Most Visited Pages: ---' }
      let(:unique_message) { '--- Most Unique Visited Pages: ---' }

      it 'returns an empty records parsed message' do
        expect { subject.print_most_visited_pages }.to output(
          a_string_including(print_nothing_parsed)
        ).to_stdout

        expect { subject.print_most_uniq_visited_pages }.to output(
          a_string_including(print_nothing_parsed)
        ).to_stdout

        expect { subject.print_most_visited_pages }.to_not output(
          a_string_including(most_visited_message)
        ).to_stdout

        expect { subject.print_nothing_parsed }.to_not output(
          a_string_including(unique_message)
        ).to_stdout
      end
    end
  end
end
