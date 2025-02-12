require "test_helper"
require "csv"

class DashboardControllerTest < ActionDispatch::IntegrationTest
  # Clean up the JSON data file before and after each test.
  def setup
    cleanup_data_file
  end

  def teardown
    cleanup_data_file
  end

  def cleanup_data_file
    data_file = User::DATA_FILE
    File.delete(data_file) if File.exist?(data_file)
  end

  test "should render dashboard index with users data" do
    # Create a user record to be displayed in the dashboard view.
    user = User.new(
      first_name: "Alice",
      last_name: "Smith",
      email: "alice@example.com",
      phone: "+1234567890"
    )
    assert user.save, "User must be saved successfully"

    # Request the dashboard index page.
    get dashboard_home_url
    assert_response :success

    # Check that the rendered page contains details of the user.
    assert_match "Alice", response.body
    assert_match "Smith", response.body
    assert_match "alice@example.com", response.body
    # Adjust assertions based on your specific view rendering.
  end

  test "should generate CSV data for dashboard users and allow download" do
    # Create a user record for CSV export.
    user = User.new(
      first_name: "Bob",
      last_name: "Brown",
      email: "bob@example.com",
      phone: "+0987654321"
    )
    assert user.save, "User must be saved successfully"

    # Request the CSV action in the dashboard.
    get csv_dashboard_url
    assert_response :success

    # Verify that the response is served as CSV.
    assert_equal "text/csv", response.media_type

    # Verify that the Content-Disposition header includes a proper filename.
    content_disposition = response.headers["Content-Disposition"]
    assert_match(/attachment; filename="users-\d+\.csv"/, content_disposition)

    # Parse the CSV data from the response.
    csv_data = CSV.parse(response.body, headers: true)
    expected_headers = ["First Name", "Last Name", "Email", "Phone", "Created At"]
    assert_equal expected_headers, csv_data.headers

    # Verify the CSV row matches the user data.
    row = csv_data.first
    assert_equal "Bob", row["First Name"]
    assert_equal "Brown", row["Last Name"]
    assert_equal "bob@example.com", row["Email"]
    assert_equal "+0987654321", row["Phone"]
    assert row["Created At"].present?, "Created At timestamp should be present"
  end
end