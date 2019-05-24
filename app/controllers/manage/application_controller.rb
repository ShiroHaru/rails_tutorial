class Manage::ApplicationController < ApplicationController
  protect_from_forgery with: :exception
  include Manage::SessionsHelper
  layout 'manage/application'
end