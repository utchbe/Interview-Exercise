$LOAD_PATH << File.dirname(__FILE__) + '/../lib'

require 'rspec'
require 'watir-webdriver'
require 'page-object'
require 'page-object/page_factory'
require 'faker'
require 'pages'
require 'httparty'
require 'json'
require 'colorize'


browser = Watir::Browser.new :chrome
browser.window.maximize

#TODO Add httparty helper methods here or in a class that can be accessed thorughout the framework

RSpec.configure do |config|
  config.include PageObject::PageFactory
  config.before(:all) { @browser = browser }
  config.after(:suite) { browser.close }
end