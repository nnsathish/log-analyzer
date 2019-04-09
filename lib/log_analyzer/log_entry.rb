module LogAnalyzer
  class LogEntry
    attr_reader :url, :ip

    IP_REGEX = /\A(?:[0-9]{1,3}\.){3}[0-9]{1,3}\Z/

    def initialize(url, ip)
      @url = url # TODO: remove trailing slash
      @ip = ip
    end

    def valid?
      return false unless url.start_with?('/') # TODO: need to be more strict
      return false unless ip.match?(IP_REGEX)
      true
    end

    def to_s
      [url, ip].join(' ')
    end
  end
end
