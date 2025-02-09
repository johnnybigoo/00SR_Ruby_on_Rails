# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_user_path, notice: "User created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @users = User.read_users
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :phone, :email)
  end
end