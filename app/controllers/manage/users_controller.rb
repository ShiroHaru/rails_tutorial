class Manage::UsersController < Manage::ApplicationController
  def show
    @user = User.find(params[:id])
    #debugger
  end

  def new
  end
end
