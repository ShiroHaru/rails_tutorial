# Preview all emails at http://localhost:3000/rails/mailers/manage/user_mailer
class Manage::UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/manage/user_mailer/account_activation
  def account_activation
    Manage::UserMailer.account_activation
    user = User.first
    user.activation_token = User.new_token
    Manage::UserMailer.account_activation(user)
  end

  # Preview this email at http://localhost:3000/rails/mailers/manage/user_mailer/password_reset
  def password_reset
    Manage::UserMailer.password_reset
  end

end
