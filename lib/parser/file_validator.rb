# frozen_string_literal: true

module Parser
  # Validates file existence
  module FileValidator
    private

    def validate_file
      invalid_file? &&
        (raise 'Invalid file path, the file does not exists')
    rescue RuntimeError => e
      logger.print_error_message_and_exit(e)
    end

    def invalid_file?
      file_name && !File.exist?(file_name)
    end
  end
end
