require "test_helper"

class Customer::DocumentsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get customer_documents_new_url
    assert_response :success
  end

  test "should get index" do
    get customer_documents_index_url
    assert_response :success
  end

  test "should get show" do
    get customer_documents_show_url
    assert_response :success
  end

  test "should get edit" do
    get customer_documents_edit_url
    assert_response :success
  end

  test "should get word_search" do
    get customer_documents_word_search_url
    assert_response :success
  end

  test "should get tag_search" do
    get customer_documents_tag_search_url
    assert_response :success
  end
end