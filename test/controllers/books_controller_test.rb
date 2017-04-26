require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  describe BooksController do
    it "should get index" do
      get books_path
      must_respond_with :success
    end

    describe "User is logged in" do
      before do
        login_user(users(:dan))
      end

      it "Can see show" do
        # Get a show page for the :Venetia Book
        get book_path(books(:venetia).id)
        must_respond_with :success
      end

    end

    describe "User is not logged in" do
      it "Cannot see show" do
        # Get a show page for the :Venetia Book
        get book_path(books(:venetia).id)
        must_respond_with :redirect
        must_redirect_to root_path
        flash[:warning].must_equal "You must be logged in to view this page"
      end
    end
  #
  #   it "should show one book" do
  #     get book_path(books(:venetia).id)
  #     must_respond_with :success
  #   end
  #
  #   it "should show a 404 when book not found" do
  #     get book_path(1)
  #     must_respond_with :missing
  #   end
  #
  #   it "should show the new book form" do
  #     get new_book_path
  #     must_respond_with :success
  #   end
  #
  #   it "should redirect to list after adding book" do
  #     post books_path, params: { book:
  #         { title: "Testing",
  #           author_id: authors(:metz).id,
  #           description: "Whatevs",
  #           isbn: rand(10..50),
  #           "genres"=>[genres(:scifi).id, genres(:fantasy).id]
  #         } }
  #     puts "Flash[error]:  #{flash[:error]}"
  #     puts "Flash[success]:  #{flash[:success]}"
  #
  #     must_redirect_to books_path
  #   end
  #
  #   it "should affect the model when creating a book" do
  #     proc {
  #       post books_path, params: { book:
  #           { title: "Testing",
  #             author_id: authors(:metz).id,
  #             description: "Whatevs",
  #             isbn: rand(10..50),
  #             "genres"=>[genres(:scifi).id, genres(:fantasy).id]
  #           }
  #     }
  #     }.must_change 'Book.count', 1
  #   end
  #
  #   it "should delete a book and redirect to book list" do
  #
  #     delete book_path(books(:venetia).id)
  #     must_redirect_to books_path
  #   end
  #
  end
end
