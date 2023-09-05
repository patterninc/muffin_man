# frozen_string_literal: true

module MuffinMan
  module EnableLogger
    LOGGING_ENABLED = true

    def log_request_and_response(level, res)
      log_info = "REQUEST\n
        canonical_uri:#{canonical_uri}\n\n
        query_params:#{query_params}\n\n
        RESPONSE\n
        response_headers=#{res.headers}\n\n
        response_body=#{res.body}\n\n
      "
      MuffinMan.logger.send(level, log_info)
    end
  end
end
