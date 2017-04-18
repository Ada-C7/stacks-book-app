class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create]

  def create
    auth_hash = request.env['omniauth.auth']

    user = User.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])

    # if its not there (in the DB) then make/save it
    if user.nil?
      user = User.create_from_github(auth_hash)

      if user.nil?
        flash[:error] = "Could not log in."
        redirect_to root_path
      end
    end

    # if it is there then save some data to session then redirect
    session[:user_id] = user.id
    flash[:success] = "Logged in successfully!"
    redirect_to root_path
  end

  def logout
    # session[:user_id] = nil
    session.delete(:user_id)
    flash[:success] = "You are successfully logged out"
    redirect_to root_path
  end

  # def login_form; end
  #
  # def login
  #   # raise
  #   author = Author.find_by_name(params[:name])
  #
  #   if author
  #     # found successfully
  #     session[:author_id] = author.id
  #     flash[:success] = "HELLO #{ author.name }"
  #     redirect_to root_path
  #   else
  #     # did not find
  #     flash.now[:error] = "Author not found"
  #     render :login_form
  #   end
  # end
  #
  # def logout
  #   # session[:author_id] = nil
  #   session.delete(:author_id)
  #   flash[:success] = "You are successfully logged out"
  #   redirect_to root_path
  # end
end
