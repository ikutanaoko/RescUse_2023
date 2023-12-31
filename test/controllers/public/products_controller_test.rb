require "test_helper"

class Public::ProductsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_products_show_url
    assert_response :success
  end

  test "should get new" do
    get public_products_new_url
    assert_response :success
  end

  test "should get edit" do
    get public_products_edit_url
    assert_response :success
  end
end
