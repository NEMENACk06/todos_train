module SimpleCov
  module Formatter
    class SimpleFormatter
      def format(result)
        puts "Coverage: #{result.covered_percent.round(2)}% covered"
      end
    end
  end
end
