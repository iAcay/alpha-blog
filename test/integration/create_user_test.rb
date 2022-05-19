require "test_helper"

class CreateUserTest < ActionDispatch::IntegrationTest

  test "get sign up form and create user" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { username: "UserTest", email: "user@example.com", password: "password" } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Welcome", response.body
    assert_select 'div.alert'
  end
end
