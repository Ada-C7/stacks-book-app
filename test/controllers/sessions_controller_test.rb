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
      # Try to log in
      proc {
        # Get the callback path for github
        # Will call the `create` action in `SessionsController`
        #user = users(:kari)
        login_user(users(:kari))

        # Check for redirection
        must_redirect_to root_path

        # Check that session was set
        session[:user_id].must_equal users(:kari).id

        # Check that a new user wasn't created
      }.must_change 'User.count', 0
    end

    it "Can create a new user" do

      # Create a user
      jamie = User.new(name: "Jamie", uid: "999", provider: "github", email: "Jamie@adadevelopersacademy.org")

      # Try to log in
      proc {
        # Get the callback path for github
        # Will call the `create` action in `SessionsController`
        login_user(jamie)

        # Check for redirection
        must_redirect_to root_path

        # Check that session was set
        session[:user_id].must_equal User.find_by(name: "Jamie").id

        # Check that a new user wasn't created
      }.must_change 'User.count', 1
    end
  end

  describe "Logging out" do
    it "I can log out a logged in user" do

      # Log in Kari
      login_user(users(:kari))
      delete logout_path

      session[:user_id].must_be_nil
      must_redirect_to root_path

    end
  end














end
