require 'log_analyzer/version'
require 'log_analyzer/log_file_parser'

module LogAnalyzer
  class Error < StandardError; end

  def self.run(fpath)
    parser = LogFileParser.new(fpath)
    parser.process
  end
end
