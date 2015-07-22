require "test_helper"
require "mocha/mini_test"

class TweetStreamsControllerTest < ActionController::TestCase
  test "fetches tweets on create" do
    jeff = stub(followers_count: 1)
    @controller.twitter_client.expects(:user).with("j3").returns(jeff)
    array = ["1", "2"]
    me = "lev"
    me.stubs(screen_name: "levthedev")
    array.each { |string| string.stubs(user: me, text: "this is my tweet") }
    @controller.twitter_client.expects(:user_timeline).with("j3").returns(array)

    post :create, :twitter_handle => "j3"
    assert_response :success
    assert_not_nil assigns(:tweets)
    assert_select "li.tweet"
  end
end
