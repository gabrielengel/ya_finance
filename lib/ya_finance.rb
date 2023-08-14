# frozen_string_literal: true

require "net/http"
require "open-uri"
require "ostruct"
require "json"
require "csv"
require 'bigdecimal'

class YaFinance
  VERSION = "0.0.7"

  def initialize(ticker, options={})
    @ticker = ticker
    @options = options
  end
  def current; Current.new(@ticker, @options); end
  def meta; Meta.new(@ticker, @options); end
  def past; Past.new(@ticker, @options); end
  def future; Future.new(@ticker, @options); end

  def results(present); Results.new(@ticker, present, @options); end
  def quarterly; Results.new(@ticker, 'quarterly', @options); end
  def yearly; Results.new(@ticker, 'yearly', @options); end
end

Dir[File.join(__dir__, 'ya_finance', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'ya_finance/scrapper', '*.rb')].each { |file| require file }
