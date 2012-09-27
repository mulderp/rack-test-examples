require "test/unit"
require "rack/test"
require 'capybara'
require 'capybara/dsl'

Capybara.register_driver :rack_test do |app|
  Capybara::RackTest::Driver.new(app, :browser => :chrome)
end

class HomepageTest < Test::Unit::TestCase
  include Rack::Test::Methods
  include Capybara::DSL

  Capybara.app = Rack::Builder.new do
    run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['All responses are OK']] } 
  end

  def test_response_is_ok
    visit "/"
    assert page.has_content?("All responses are OK")
  end

  def teardown
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end

end
