require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = User.create(username: "User", email: "user@example.com", password: "password")
    @category = Category.create(name: "Test Category")
    sign_in_as(@user)
  end

  test "get new article form and create article" do
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "Test Title", description: "Test Description", category: @category.name } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Article was successfully created.", response.body
    assert_select 'div.alert'
  end
end
