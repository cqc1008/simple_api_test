require 'fileutils'

class String
  def underscore
    return document if match(/\A[A-Z]+\z/)
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    downcase
  end
end

module SimpleApiTest
  module Helpers
    module Reporter
      class << self
        def included(base)
          base.class_eval do
            alias_method :initialize_without_report, :initialize

            def initialize
              initialize_without_report
              clear_report
            end

            alias_method :request_without_report, :request

            def request(url, method = 'GET', options_string = '')
              request_without_report(url, method, options_string)
              output_report
            end
          end
        end
      end

      def report_dir
        dir = 'reports'
        FileUtils.mkdir_p(dir) unless Dir.exists?(dir)
        return dir
      end

      def report_file
        File.join(report_dir, "#{self.class.to_s.gsub('Test', '').underscore}.txt")
      end

      def clear_report
        File.open(report_file, 'w+') { |f| f.write('') }
      end

      def format_report
        separator = '#' * 50
        content  = "#{separator}\r\n"
        content += "#{@last_request_cmd}\r\n"
        content += "#{separator}\r\n"
        content += "#{@last_request_output}\r\n"
        content += "#{separator}\r\n"
        content += "\r\n\r\n"
      end

      def output_report
        File.open(report_file, 'a+') { |f| f.write(format_report) }
      end
    end
  end
end
