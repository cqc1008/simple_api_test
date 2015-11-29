# HOST = 'localhost'
# PORT = '3000'

module SimpleApiTest
  module Helpers
    module Url
      class << self
        def included(base)
          base.class_eval do
            alias_method :request_without_full_url, :request

            def request(url, method = 'GET', options_string = '')
              request_without_full_url(full_url(url), method, options_string)
            end
          end
        end
      end

      def full_url(url)
        "http://#{HOST}:#{PORT}/#{url}"
      end
    end
  end
end
