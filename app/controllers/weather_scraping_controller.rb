require 'mechanize'
require "date"
class WeatherScrapingController < ApplicationController
  attr_reader :prec_no, :block_no, :date, :url

  def index
    

    @y_day = Date.yesterday
    @y_day_year = @y_day.year
    @y_day_month = @y_day.month
    @y_day_day = @y_day.day

    @start_date = Date.new(2022,02,02)
    @start_year = @start_date.year
    @start_month = @start_date.month
    @start_day = @start_date.day

    @term_month = (@y_day_month - @start_month).to_i + 1
    @term = (@y_day - @start_date).to_i  #期間＝取得するデータの数
    @temps =[] #空の配列を作成して取得データを追加
    
    @term_month.times do |m|
      url = "http://www.data.jma.go.jp/obd/stats/etrn/view/daily_s1.php?prec_no=48&block_no=47618&year=#{@start_year}&month=#{@start_month+m}&day=#{@start_day}&view="
      agent = Mechanize.new
      page = agent.get(url)
      
      td_length = page.search("//*[@id='tablefix1']/tr").length-4 #td要素の上４つは項目なので、全ｔｄ要素から4を引いた数がデータの数になる
      
      if m == 0 #スタートの月
        (td_length-(@start_day-1)).times do |i|
          ave_temp = page.search("//*[@id='tablefix1']/tr[#{5+(@start_day-1)+i}]").search('td')[6].inner_text #７番目のtdタグが日平均気温
          @temps << ave_temp.delete("^0-9.-") #配列として@tempsに順に追加
        end
      elsif m == @term_month - 1 #最後の月
        @y_day_day.times do |i|
          ave_temp = page.search("//*[@id='tablefix1']/tr[#{5+i}]").search('td')[6].inner_text #７番目のtdタグが日平均気温
          @temps << ave_temp.delete("^0-9.-") #配列として@tempsに順に追加
        end
      else     #中間の月
        td_length.times do |i|
          ave_temp = page.search("//*[@id='tablefix1']/tr[#{5+i}]").search('td')[6].inner_text #７番目のtdタグが日平均気温
          @temps << ave_temp.delete("^0-9.-") #配列として@tempsに順に追加
        end
      end




    end



    @total_temp = 0
    
    @temps.each do |temp|
    temp = temp.to_i
      if temp < 0
        temp = 0 #0度以下はデータとして加算しない
      end
      @total_temp += temp
    end



  end

  
end
