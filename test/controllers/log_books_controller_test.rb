require 'test_helper'

class LogBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get log_books_index_url
    assert_response :success
  end

  test "should get edit" do
    get log_books_edit_url
    assert_response :success
  end

end
