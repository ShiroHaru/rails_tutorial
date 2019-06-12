class Manage::MicropostsController < Manage::ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user, only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to manage_root_url
    else
      @feed_items = []
      render 'manage/static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    # リファラーで1つ前のURLへリダイレクト
    # このため、マイクロポストがHomeページから削除された場合でもプロフィールページから削除された場合でも、request.referrerを使うことでDELETEリクエストが発行されたページに戻すことができる
    redirect_to request.referrer || manage_root_url
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      # 現在のユーザーが削除しようとしているmicropostを所有しているか調べる
      @micropost = current_user.microposts.find_by(id: params[:id])
      # nilの場合は所有していないのでリダイレクト
      redirect_to manage_root_url if @micropost.nil?
    end
end
