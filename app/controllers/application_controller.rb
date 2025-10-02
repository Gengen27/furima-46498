class ApplicationController < ActionController::Base
  include Gon::ControllerHelpers # Gonのモジュールを正しく読み込む

  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_gon

  protected

  # Deviseサインアップ時に追加カラムを許可
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [
                                        :nickname, :last_name, :first_name,
                                        :last_name_kana, :first_name_kana, :birthday
                                      ])
  end

  private

  # Basic認証
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] &&
        password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  # JSに環境変数を渡す
  def set_gon
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end
end
