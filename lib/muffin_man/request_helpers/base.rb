require "active_support/core_ext/object/blank"
require "active_support/core_ext/hash"

module MuffinMan
  module RequestHelpers
    class Base
      def self.json_body(*args)
        new(*args).json_body
      end

      def initialize(*args); end

      def json_body
        {}
      end
    end
  end
end
