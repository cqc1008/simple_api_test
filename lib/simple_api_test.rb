$:.unshift File.expand_path('..', __FILE__)

require 'simple_api_test/test_case'

module SimpleApiTest
  class << self
    def run(testcases = nil)
      @errors = []
      @failures = []
      (testcases || TestCase.all).each do |test_case_class|
        instance = test_case_class.new
        instance.public_methods.select { |m| m.to_s.start_with?('test_') }.each do |method|
          begin
            instance.send(method)
            print '.'
          rescue AssertionFailed => e
            print 'F'
            @failures << e
          rescue => e
            print 'E'
            @errors << e.backtrace.join("\r\n")
          end
        end
      end
      print "\r\n\r\n"
      p "Error: #{@errors.size}  Failures: #{@failures.size}"
      (@errors + @failures).each do |message|
        print "\r\n"
        print message
        print "\r\n"
      end
    end
  end
end
