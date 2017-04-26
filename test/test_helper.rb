ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"

require "minitest/reporters"  # for Colorized output

#  For colorful output!
Minitest::Reporters.use!(
Minitest::Reporters::SpecReporter.new,
ENV
)

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
# require "minitest/rails/capybara"

# Uncomment for awesome colorful output
# require "minitest/pride"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def login_user(user)

    # Set the "Fake or mock" Auth Hash for Github
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

    get auth_github_callback_path
  end

  def mock_auth_hash(user)
     {
      provider: user.provider,
      uid: user.uid,
      info: {
        email: user.email,
        name: user.name
      }
    }
  end


  def setup
    OmniAuth.config.test_mode = true
  end














    # Add more helper methods to be used by all tests here...
end
