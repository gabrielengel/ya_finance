require 'oga'

class YaFinance
  class Scrapper
    class Holders
      def self.process(html)
        doc = Oga.parse_xml(html)
        table = doc.css('[data-test] td').map{|e| e.text }
        {
          insiders_percent: table[0].to_f,
          intitutions_percent: table[2].to_f,
          institutions_float: table[4].to_f,
          institutions_amount: table[6].to_i
        }
      end
    end
  end
end
