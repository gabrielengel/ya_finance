require 'oga'

class YaFinance
  class Scrapper
    class Calendar
      def self.process(html)
        doc = Oga.parse_xml(html)
        response = []
        doc.css('.simpTblRow').each do |line|
          date = DateTime.parse line.css('[aria-label="Earnings Date"]').text
          estimate = line.css('[aria-label="EPS Estimate"]').text
          reported = line.css('[aria-label="Reported EPS"]').text
          surprise = line.css('[aria-label="Surprise(%)"]').text
          response.push({date: date, estimate: estimate, reported: reported, surprise: surprise })
        end
        response
      end
    end
  end
end
