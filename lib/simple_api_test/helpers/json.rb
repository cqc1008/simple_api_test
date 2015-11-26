require 'json'

module SimpleApiTest
  module Helpers
    module Json
      def result_as_json
        m = @last_request_output.match(/^\{.*\}$/)
        if m.nil?
          {}
        else
          JSON.parse(m[0])
        end
      end
    end
  end
end
