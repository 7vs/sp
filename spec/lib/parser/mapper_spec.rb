# frozen_string_literal: true

require 'rspec'
require 'rspec/file_fixtures'
require 'parser/mapper'
require 'parser/parrot'

describe Parser::Mapper do
  context 'given a file including the latest visits' do
    subject do
      described_class.new(file_name, logger, regexp)
    end

    let(:logger) { Parser::Parrot }
    let(:regexp) { ::Regexp }

    context 'transform the content to get totals from each file line' do
      let(:file_name) { fixture('webserver_test.log') }

      let(:most_visited) do
        [['/home', 19], ['/about', 19], ['/help_page/1', 18], ['/about/2', 17]]
      end

      let(:unique) do
        [['/home', 14], ['/about', 13], ['/help_page/1', 12], ['/about/2', 12]]
      end

      let(:totals) do
        [most_visited, unique]
      end

      it 'returns most visited and unique pages in arrays' do
        expect(subject.transform_lines).to eq(totals)
      end
    end

    context 'given a file including invalid logs' do
      let(:file_name) { fixture('invalid_logs.log') }

      it 'returns an array of empty arrays' do
        expect(subject.transform_lines).to eq([[], []])
      end
    end
  end
end
