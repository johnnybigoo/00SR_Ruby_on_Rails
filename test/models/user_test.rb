require "test_helper"
require 'fileutils'

class UserTest < ActiveSupport::TestCase
  def setup
    cleanup_data_file
  end

  def teardown
    cleanup_data_file
  end

  def test_should_save_valid_user
    user = User.new(
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@example.com',
      phone: '+1234567890'
    )
    assert user.valid?, "User should be valid with correct attributes"
    assert user.save, "User must be saved successfully"
    users = User.read_users
    assert_equal 1, users.size, "One user should be saved"
  end

  def test_should_not_save_invalid_user
    user = User.new(
      first_name: '',
      last_name: '',
      email: 'invalid',
      phone: '123'
    )
    assert_not user.valid?, "User should be invalid with wrong attributes"
    assert_not user.save, "User saving should fail"
  end

  def test_attributes_for_storage_formats_data_correctly
    user = User.new(
      first_name: ' John ',
      last_name: ' Doe ',
      email: 'John@example.COM ',
      phone: ' +1234567890 '
    )
    storage = user.attributes_for_storage
    assert_equal 'John', storage[:first_name], "Whitespace should be stripped from first_name"
    assert_equal 'Doe', storage[:last_name], "Whitespace should be stripped from last_name"
    assert_equal 'john@example.com', storage[:email], "Email should be downcase and stripped"
    assert_equal '+1234567890', storage[:phone], "Phone should be stripped correctly"
    assert storage[:created_at].present?, "A timestamp should be stored in created_at"
  end

  private

  def cleanup_data_file
    data_file = User::DATA_FILE
    File.delete(data_file) if File.exist?(data_file)
  end
end