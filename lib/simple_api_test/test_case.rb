module SimpleApiTest
  class TestCase
    def initialize
      clear_report
    end

    @subclasses = []

    class << self
      def inherited(subclass)
        @subclasses << subclass
      end

      def all
        @subclasses
      end
    end

    private

      def assert(result, message = '')
        raise AssertionFailed.new(message) unless result
      end

      def assert_success(message = '')
        assert @last_request_output.include?('HTTP/1.1 2'), message
      end

      def request(url, method = 'GET', options_string = '')
        @last_request_cmd = %Q(curl -is -X #{method} "#{url}" #{options_string})
        @last_request_output = `#{@last_request_cmd}`
      end
  end
end
