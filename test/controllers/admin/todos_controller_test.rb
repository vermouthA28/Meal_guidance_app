require "test_helper"

class Admin::TodosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_todos_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_todos_edit_url
    assert_response :success
  end
end
