# frozen_string_literal: true

require 'rspec'
require 'ostruct'
require 'parser/parrot'

describe Parser::Parrot do
  context 'when a message to raise invalid ipv4 ips is needed' do
    let(:warning_message) { '--- We are still parsing invalid Ipv4s. ---' }

    it 'raises a warning message' do
      expect { subject.print_invalid_ipv4_message }.to output(a_string_including(warning_message)).to_stdout
    end
  end

  context 'given an error object' do
    context 'with a message included' do
      let(:error) { OpenStruct.new(message: 'black') }
      let(:error_message) { %(Error message: black) }

      before do
        allow(subject).to receive(:exit).and_return(true)
      end

      it 'returns most visited and unique pages in arrays' do
        expect { subject.print_error_message_and_exit(error) }.to output(a_string_including(error_message)).to_stdout
      end
    end
  end
end
