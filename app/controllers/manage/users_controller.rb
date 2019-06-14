class Manage::UsersController < Manage::ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :check_current_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    redirect_to manage_root_url and return unless @user.activated
    #debugger
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to manage_root_url

      #log_in @user
      #flash[:success] = "Welcome to the Sample App!"
      #redirect_to [:manage, @user]
    else
      render 'new'
    end
  end

  def edit
    logger.debug('///////def edit')
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to [:manage, @user]
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to manage_users_url
  end

  # フォローしているユーザーを表示
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  # フォローされているユーザーを表示
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

  #正しいユーザーかどうか確認
    def check_current_user
      @user = User.find(params[:id])
      redirect_to(manage_root_url) unless current_user?(@user)
    end

  #管理者かどうか
    def admin_user
      redirect_to(admin_root_url) unless current_user.admin?
    end
end
