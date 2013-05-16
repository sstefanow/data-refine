# encoding: UTF-8
require 'uri'

# Podstawowa metoda by JMudry
# Wpakowanie w moduł i lekka modyfikacja by DSawa
module ChartGenerator

  GOOGLE_CHARTS_URL = 'http://chart.apis.google.com/chart'

  # Słupkowy (domyślnie) i kołowy działają napewno
  def self.get_chart_url(tab, x_label, y_label, options = {})
    max_value = tab.collect { |hash| hash[x_label] }.max
    ratio = 100.to_f/max_value.to_f
    reversing_charts = %w(p p3 pc bvg)
    chd = []
    chxl =[]

    tab.sort_by! { |hash| hash[x_label] } if options[:sort]

    tab.count.times do |i|
      chd << (tab[i][x_label].to_f * ratio)
      chxl << tab[i][y_label]
    end

    chxl.reverse! unless reversing_charts.include?(options[:cht])

    chart_params = {
      chs: options[:chs] || "600x#{tab.count*35}",
      cht: options[:cht] || "bhg",
      chxt: options[:chxt] || "x,y",
      chxr: "0,0,#{max_value}",
      chd: "t:#{chd.join(",")}",
      chxl: "1:|#{chxl.join("|")}"
    }

    "#{GOOGLE_CHARTS_URL}?#{URI.encode_www_form(chart_params)}"
  end

end