class Manage::RelationshipsController < Manage::ApplicationController
  before_action :logged_in_user

  # リスト 14.33: Relationshipsコントローラ
  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)  # Userモデルのフォロワーを追加するメソッド
    # redirect_to [:manage, user]

    # リスト 14.36: RelationshipsコントローラでAjaxリクエストに対応する
    respond_to do |format|
      format.html {redirect_to [:manage, @user]}
      format.js
    end
  end

  # リスト 14.33: Relationshipsコントローラ
  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow(@user)  # Userモデルのフォロワーを削除するメソッド
    # redirect_to [:manage, user]

    # リスト 14.36: RelationshipsコントローラでAjaxリクエストに対応する
    respond_to do |format|
      format.html {redirect_to [:manage, @user]}
      format.js
    end
  end
end
