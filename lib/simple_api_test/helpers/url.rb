# HOST = 'localhost'
# PORT = '3000'

module SimpleApiTest
  module Helpers
    module Url
      def full_url(url)
        "http://#{HOST}:#{PORT}/#{url}"
      end
    end
  end
end
