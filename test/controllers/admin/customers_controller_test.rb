require "test_helper"

class Admin::customersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_customers_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_customers_edit_url
    assert_response :success
  end

  test "should get word_search" do
    get admin_customers_word_search_url
    assert_response :success
  end
end
