# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string(255)
#  name            :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ApplicationRecord
  #ユーザー登録でemailを小文字に変換してdbに保存
  before_save {self.email = self.email.downcase}

  validates :name, presence: true, length: {maximum: 50}

  #メールアドレスチェックの正規表現
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 255}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}

  #has_secure_passwordメソッドの呼び出し
  has_secure_password

  #has_secure_passwordによって自動的に追加された属性passwordのバリデーション
  validates :password, presence: true, length: {minimum: 6}
end
