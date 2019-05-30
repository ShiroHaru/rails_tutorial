class Manage::SessionsController < Manage::ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])

      if user.activated?
        log_in user
        #ログイン情報を記憶するかしないか
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or [:manage, user]
      else
        message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to manage_root_url
      end
    else
      #エラーメッセージを作成
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
  
  def destroy
    logger.debug('logged_in?')
    logger.debug(logged_in?)
    log_out if logged_in?
    redirect_to manage_root_url
  end
end
