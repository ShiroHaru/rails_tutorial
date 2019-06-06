class Manage::PasswordResetsController < Manage::ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  # emailを入力してパスワードリセットメールを送るフォーム
  def new
  end

  # 入力されたemailからパスワードリセットメールを送る
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      #flash[:info] = "Email sent with password reset instructions"
      flash[:info] = "パスワードリセットのメールを送りました"
      redirect_to manage_root_url
    else
      #flash.now[:danger] = "Email address not found"
      flash.now[:danger] = "メールアドレスが見つかりません"
      render 'new'
    end
  end

  # パスワードリセットメールのリンク先、新しいパスワードの入力フォーム
  def edit
  end

  def update
    if params[:user][:password].empty?
      # 新しいパスワードが空文字列の場合

      # 新しいパスワードの入力画面に返す
      @user.errors.add(:password, :blank)
      render 'edit'
    elsif @user.update_attributes(user_params)
      # パスワードの再設定が成功した場合
      # update_attributes はdbの情報を更新する、その際バリデーションも実行されるので失敗するとfalseが帰る

      #ログイン処理
      log_in @user

      #再設定が成功したのでdbのreset_digestをnilにする
      @user.update_attribute(:reset_digest, nil)

      #flash[:success] = "Password has been reset."
      flash[:success] = "パスワードがリセットされました."
      redirect_to [:manage, @user]
    else
      # 無効なパスワードだった場合

      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

  # パラメーターのemailからユーザーを取得する
    def get_user
      @user = User.find_by(email: params[:email])
    end

  # 正しいユーザーかどうか確認する
    def valid_user
      # ACTIVATED(アクティベーション)が完了していなくてもパスワードの変更ができるようにするために
      # unless の条件から @user.activated? を外す
      unless (@user && @user.authenticated?(:reset, params[:id]))
        #flash[:danger] = "アクティベーションが完了していません"
        redirect_to manage_root_url
      end
    end

  # 期限切れかどうかを確認する
    def check_expiration
      if @user.password_reset_expired? # 有効期限が切れている場合
        #flash[:danger] = "Password reset has expired."
        flash[:danger] = "パスワードリセットの有効期限が切れています"
        redirect_to new_manage_password_reset_url
      end
    end
end
