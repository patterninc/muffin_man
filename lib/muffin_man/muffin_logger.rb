require 'logger'
module MuffinMan
  class MuffinLogger

    def self.logger
      defined?(Rails) ? Rails.logger : Logger.new(STDOUT)
    end

    [:debug, :info, :warn, :error, :fatal].each do |level|
      define_method(level) do |message|
        MuffinLogger.logger.send(level, message)
      end
    end
  end
end
