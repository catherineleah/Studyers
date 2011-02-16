require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should login" do
    dave = users(:one)
    post :create, :email => dave.email, :password => 'secret'
    assert_redirected_to user_url
    assert_equal dave.id, session[:user_id]
  end
  test "should fail login" do
    dave = users(:one)
    post :create, :name => dave.name, :password => 'wrong'
    assert_redirected_to login_url
  end
  test "should logout" do
    delete :destroy
    assert_redirected_to login_url
  end
  #test "should get create" do
  #  get :create
  #  assert_response :success
  #end

  #test "should get destroy" do
  #  get :destroy
  #  assert_response :success
  #end

end
