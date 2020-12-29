require 'test_helper'
#integration tests the whole business process for a feature that can include multiple functions.
class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get new category form and create category" do
    get "/categories/new"
    assert_response :success
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: {name: "Sports"}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "get new category form and reject invalid category submission" do
    get "/categories/new"
    assert_response :success
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: {name: ""}}
    end
    assert_match "errors", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
    #allows us to check for specific elements in the page
  end
end
