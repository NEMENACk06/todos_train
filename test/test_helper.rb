# test/test_helper.rb หรือ spec/spec_helper.rb ก่อน SimpleCov.start
require 'simplecov'
require Rails.root.join('lib/simple_cov/formatter/simple_formatter')

SimpleCov.formatters = [
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::SimpleFormatter
]
SimpleCov.start 'rails'
