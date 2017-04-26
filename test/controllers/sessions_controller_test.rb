require "test_helper"

describe SessionsController do
  # it "must be a real test" do
  #   flunk "Need real tests"
  # end

  describe "auth_callback" do

    it "Cannot login without a valid Auth_Hash" do

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({})
      proc {
        # Get the callback path for github
        # Will call the `create` action in `SessionsController`
        get auth_github_callback_path

        # Check for redirection
        must_redirect_to root_path

        # Check that session was set
        session[:user_id].must_be_nil
        flash[:error].must_equal "Could not log in."

        # Check that a new user wasn't created
      }.must_change 'User.count', 0

    end

    it "Can login an existing user" do
      # Get a user from Fixtures
      user = users(:kari)

      # Set the "Fake or mock" Auth Hash for Github
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      # Try to log in
      proc {
        # Get the callback path for github
        # Will call the `create` action in `SessionsController`
        get auth_github_callback_path

        # Check for redirection
        must_redirect_to root_path

        # Check that session was set
        session[:user_id].must_equal user.id

        # Check that a new user wasn't created
      }.must_change 'User.count', 0
    end

    it "Can create a new user" do

      # Create a user
      user = User.new(name: "Jamie", uid: "999", provider: "github", email: "Jamie@adadevelopersacademy.org")

      # Set the "Fake or mock" Auth Hash for Github
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      # Try to log in
      proc {
        # Get the callback path for github
        # Will call the `create` action in `SessionsController`
        get auth_github_callback_path

        # Check for redirection
        must_redirect_to root_path

        # Check that session was set
        session[:user_id].must_equal User.find_by(name: "Jamie").id

        # Check that a new user wasn't created
      }.must_change 'User.count', 1
    end
  end






end
