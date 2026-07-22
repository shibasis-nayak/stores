require "capybara/rspec"
require "selenium-webdriver"

Capybara.default_driver = :selenium_chrome
Capybara.javascript_driver = :selenium_chrome

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new

  options.add_argument("--window-size=1400,1000")
  options.add_argument("--disable-gpu")

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    options: options
  )
end
