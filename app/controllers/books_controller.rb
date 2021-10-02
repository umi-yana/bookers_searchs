class BooksController < ApplicationController
  before_action :authenticate_user!
#   before_action :current_user, only:[:edit]

def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
        flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book)
    else
    @user = current_user
    @books = Book.all
    render :index
    end 
end

def show
  @new_book = Book.new
  @book = Book.find(params[:id])
  @user = @book.user
end

def index
    @books = Book.all
    @book = Book.new
    @user = current_user
    @users = User.all
end


# ーーー登録ユーザーのみ表示ーーー


  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
      flash[:notice] = "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

# ーーー（end)登録ユーザーのみ表示ーーー


private
  def book_params
    params.require(:book).permit(:title,:body,:profile_image)
  end

end
