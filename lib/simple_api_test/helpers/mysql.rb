require 'rexml/document'

# DEFAULT_DB = 'mater'

module SimpleApiTest
  module Helpers
    module Mysql
      def db_execute(sql, db = DEFAULT_DB)
        output = `mysql -uroot -proot -NX -D #{db} -e "#{sql}"`
        xml = REXML::Document.new(output)
        return xml.get_elements('resultset').first
      end
    end
  end
end
