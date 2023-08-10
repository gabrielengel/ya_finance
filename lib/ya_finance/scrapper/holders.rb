require 'oga'

class YaFinance
  class Scrapper
    class Holders
      def self.process(html)
        doc = Oga.parse_xml(html)
        #TODO: organize result tables
        holders = doc.css('[data-test] td').map{|e| e.text }
        institutional = doc.css('.BdT td').map{|e| e.text } # 0
        funds = doc.css('.BdT td').map{|e| e.text } # 1
        {holders: holders, institutional: institutional, funds: funds}
      end
    end
  end
end
