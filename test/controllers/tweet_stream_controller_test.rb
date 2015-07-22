require "test_helper"
require "mocha/mini_test"

class TweetStreamsControllerTest < ActionController::TestCase
  test "fetches tweets on create" do
    jeff = stub(followers_count: 1)
    @controller.twitter_client.expects(:user).with("j3").returns(jeff)

    post :create, :twitter_handle => "j3"
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
  end
end
