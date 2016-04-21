require 'test_helper'

class ChartApiControllerTest < ActionController::TestCase
  test "should get getLast30Days" do
    get :getLast30Days
    assert_response :success
  end

end
