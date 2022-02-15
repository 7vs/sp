# frozen_string_literal: true

require 'rspec'
require 'rspec/file_fixtures'
require 'parser'

describe Parser do
  context 'When parsing server logs' do
    subject do
      Parser.execute(file_name: file_path)
    end

    context 'given a file including the latest visits' do
      let(:file_path) { fixture('webserver_test.log') }

      let(:most_visited) do
        %(/home: 19\n/about: 19\n/help_page/1: 18\n/about/2: 17)
      end

      let(:unique) do
        %(/home: 14\n/about: 13\n/help_page/1: 12\n/about/2: 12)
      end

      it 'returns most visited pages' do
        expect { subject }.to output(a_string_including(most_visited)).to_stdout
      end

      it 'returns most unique visited pages' do
        expect { subject }.to output(a_string_including(unique)).to_stdout
      end
    end

    context 'given a file including invalid logs' do
      let(:file_path) { fixture('invalid_logs.log') }
      let(:invalid_logs) { '--- There was not a valid record to parse --' }

      it 'returns an empty records parsed message' do
        expect { subject }.to output(
          a_string_including(invalid_logs)
        ).to_stdout
      end
    end

    context 'when logs contain valid ipv4 ips' do
      let(:file_path) { fixture('valid_ipv4_logs.log') }
      let(:invalid_logs) { '--- We are still parsing invalid Ipv4s. ---' }

      it 'returns an array of empty arrays' do
        expect { subject }.to_not output(
          a_string_including(invalid_logs)
        ).to_stdout
      end
    end
  end
end
