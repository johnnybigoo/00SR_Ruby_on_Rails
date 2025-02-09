class DashboardController < ApplicationController
  require 'csv'

  def index
    @users = User.read_users
  end

  def csv
    users = User.read_users

    csv_data = CSV.generate(headers: true) do |csv|
      csv << ["First Name", "Last Name", "Email", "Phone", "Created At"]
      users.each do |user|
        csv << [
          user.first_name,
          user.last_name,
          user.email,
          user.phone,
          user.created_at
        ]
      end
    end

    send_data csv_data, filename: "users-#{Time.current.strftime('%Y%m%d%H%M%S')}.csv"
  end
end