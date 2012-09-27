require "test/unit"
require "rack/test"

class HomepageTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    app = lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['All responses are OK']] }
    builder = Rack::Builder.new
    builder.run app
  end

  def test_response_is_ok
    get "/"

    assert last_response.ok?
    assert_equal last_response.body, "All responses are OK"
  end

  def test_response_is_ok_at_for_other_paths
    get "/other_paths"

    assert last_response.ok?
    assert_equal last_response.body, "All responses are OK"
  end

end
