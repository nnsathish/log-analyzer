require 'log_analyzer/log_entry'

module LogAnalyzer
  class LogFileParser
    attr_reader :fpath, :entries

    def initialize(fpath)
      @fpath = fpath
      @entries = []
    end

    def process
      parse
      stats(group_visits)
    end

    private

    def parse
      raise Error.new('Logfile not found') unless File.exist?(fpath)

      File.foreach(fpath) do |row|
        url, ip = row.split(' ')
        le = LogEntry.new(url, ip)
        raise Error.new('Malformed log file') unless le.valid?
        @entries << le
      end
    end

    def group_visits
      result = {}
      self.entries.each do |le|
        result[le.url] ||= { total_views: 0, unique_views: 0 }
        result[le.url][le.ip] ||= 1
        result[le.url][:total_views] += 1
        result[le.url][:unique_views] = result[le.url].size - 2
      end
      result
    end

    def stats(grouped_visits)
      [:total_views, :unique_views].each_with_object({}) do |stat, res|
        res[stat] = grouped_visits
          .sort_by { |url, data| [data[stat], url] }
          .reverse
          .map { |url, data| [url, data[stat]] }
      end
    end
  end
end
