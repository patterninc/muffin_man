# frozen_string_literal: true

require "logger"
module MuffinMan
  class MuffinLogger

    def self.logger
      MuffinMan.configuration&.log_with || Logger.new($stdout)
    end

    %i[debug info warn error fatal].each do |level|
      define_method(level) do |message|
        MuffinLogger.logger.send(level, message)
      end
    end
  end
end
