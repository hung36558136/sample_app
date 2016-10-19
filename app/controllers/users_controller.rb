class UsersController < ApplicationController
  before_action :confirms_login_user, except: [:show, :create, :new]
  before_action :confirms_correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :load_user, only: [:show, :edit, :update]

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new user_params
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = t ".Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user)
      .permit(:name, :email, :password, :password_confirmation)
  end

  def confirms_login_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def confirms_correct_user
    @user = User.find_by id: params[:id]
    redirect_to(root_url) unless current_user?(@user)
  end

  def destroy
    User.find_by(id: params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
