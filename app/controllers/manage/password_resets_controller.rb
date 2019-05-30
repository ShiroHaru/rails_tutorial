class Manage::PasswordResetsController < Manage::ApplicationController
  # emailを入力してパスワードリセットメールを送るフォーム
  def new
  end

  # 入力されたemailからパスワードリセットメールを送る
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to manage_root_url
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  # パスワードリセットメールのリンク先、新しいパスワードの入力フォーム
  def edit

  end
end
