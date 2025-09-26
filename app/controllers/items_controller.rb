class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # 商品一覧表示
  end

  def new
    # 新規商品登録フォーム
  end

  def create
    # 商品登録処理
  end
end

