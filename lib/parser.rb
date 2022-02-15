# frozen_string_literal: true

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'parser/arranger'

# Top level module exposing the public interface
# Ordered total and unique visits' logs Parser
module Parser
  def self.execute(file_name: file_path)
    Arranger.new(file_name).execute
  end
end
