class UsersController < ApplicationController
  
  before_action :authenticate_user!
  before_action :current_user, only:[:edit,:update]
    
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
    @not_current_user = User.where.not(id: @user.id)
  end
    
  def show
    @user = User.find(params[:id])
    @user_books = @user.books
    @book = Book.new
    @books = Book.all
  end
    
  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render :edit
    else
      redirect_to user_path(current_user)
    end
  end
    
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path
    else
      render :edit
    end 
  end
  
  
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  
  def followers
     user = User.find(params[:user_id])
     @users = user.followers
  end
  
  private
   def user_params
    params.require(:user).permit(:name,:introduction,:profile_image)
   end
     
end