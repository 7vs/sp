# frozen_string_literal: true

require 'rspec'
require 'rspec/file_fixtures'
require 'parser/arranger'

describe Parser::Arranger do
  context 'When parsing server logs' do
    subject { described_class.new(file_path) }

    let(:file_path) { fixture('webserver_test.log') }

    context 'given a file including the latest visits' do
      let(:most_visited) do
        %(/home: 19\n/about: 19\n/help_page/1: 18\n/about/2: 17)
      end

      let(:unique) do
        %(/home: 14\n/about: 13\n/help_page/1: 12\n/about/2: 12)
      end

      it 'returns most visited pages' do
        expect { subject.execute }.to output(a_string_including(most_visited)).to_stdout
      end

      it 'returns most unique visited pages' do
        expect { subject.execute }.to output(a_string_including(unique)).to_stdout
      end
    end

    context 'the model Parser in this file includes a constant' do
      let(:tool_hash) do
        {
          mapper: Parser::Mapper,
          printer: Parser::Gutenberg,
          logger: Parser::Parrot,
          regexp: ::Regexp
        }
      end

      it 'for printing and debugging' do
        expect(Parser::TOOLS).to eq(tool_hash)
      end
    end
  end
end
