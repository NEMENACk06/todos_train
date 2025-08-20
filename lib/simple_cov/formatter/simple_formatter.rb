# lib/simple_cov/formatter/simple_formatter.rb
module SimpleCov
  module Formatter
    class SimpleFormatter
      def format(result)
        percent = format("%.2f", result.covered_percent)
        puts "Coverage: #{percent}%"
        FileUtils.mkdir_p(Rails.root.join("coverage"))
        File.write(Rails.root.join("coverage", "summary.txt"), "Coverage: #{percent}%\n")
      end
    end
  end
end
