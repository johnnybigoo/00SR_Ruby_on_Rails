# app/models/user.rb
require 'active_model'
require 'mutex_m'
require 'json'

class User
  include ActiveModel::Model
  include ActiveModel::Attributes
  extend Mutex_m

  # Define a constant path for JSON storage.
  DATA_FILE = Rails.root.join('data', 'users.json').freeze

  # Define attributes.
  attribute :first_name, :string
  attribute :last_name, :string
  attribute :phone, :string
  attribute :email, :string
  attribute :created_at, :datetime

  # Validations.
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone, format: { with: /\A\+?\d{10,15}\z/ }, allow_blank: true

  # Save the user if valid; persist data to JSON.
  def save
    return false unless valid?

    User.synchronize do
      users = self.class.read_users
      users << self
      self.class.write_users(users)
    end
    true
  end

  # Read user objects from the JSON file.
  def self.read_users
    return [] unless File.exist?(DATA_FILE)
    JSON.parse(File.read(DATA_FILE)).map do |user_data|
      new(user_data)
    end
  rescue JSON::ParserError => e
    Rails.logger.error "JSON Error: #{e.message}"
    []
  end

  # Write user objects to the JSON file.
  def self.write_users(users)
    FileUtils.mkdir_p(File.dirname(DATA_FILE))
    File.write(DATA_FILE, JSON.pretty_generate(users.map(&:attributes_for_storage)))
  end

  # Prepare attributes for storage in JSON.
  def attributes_for_storage
    {
      first_name: first_name.strip,
      last_name: last_name.strip,
      phone: phone.to_s.strip,
      email: email.downcase.strip,
      created_at: Time.current.iso8601
    }
  end
end