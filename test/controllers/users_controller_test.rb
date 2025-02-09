require "test_helper"
require 'fileutils'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    cleanup_data_file
  end

  def teardown
    cleanup_data_file
  end

  test "should get new" do
    get new_user_url
    assert_response :success
    assert_select "h1", "Register New User"
  end

  test "should create user" do
    assert_difference(-> { User.read_users.size }, 1) do
      post users_url, params: { user: {
        first_name: 'Jane',
        last_name: 'Doe',
        email: 'jane@example.com',
        phone: '+441234567890'
      } }
    end
    assert_redirected_to new_user_url
  end

  test "should fail to create an invalid user" do
    assert_no_difference(-> { User.read_users.size }) do
      post users_url, params: { user: {
        first_name: '',
        last_name: '',
        email: 'invalid',
        phone: '123'
      } }
    end
    assert_response :unprocessable_entity
    # This will now match because the rendered view includes the "Error(s):" heading.
    assert_select "div", /error/i
  end

  private

  def cleanup_data_file
    data_file = User::DATA_FILE
    File.delete(data_file) if File.exist?(data_file)
  end
end