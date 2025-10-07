require 'rails_helper'

RSpec.describe 'Items', type: :request do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    {
      name: 'テスト商品',
      description: 'テスト用の商品説明',
      category_id: 2,
      condition_id: 2,
      shipping_fee_id: 2,
      prefecture_id: 2,
      shipping_day_id: 2,
      price: 500,
      image: fixture_file_upload(Rails.root.join('spec/fixtures/files/test_image.png'), 'image/png')
    }
  end

  let(:invalid_attributes) do
    {
      name: '',
      description: '',
      category_id: 1,
      condition_id: 1,
      shipping_fee_id: 1,
      prefecture_id: 1,
      shipping_day_id: 1,
      price: '',
      image: nil
    }
  end

  describe 'GET /items/new' do
    context 'ログインしている場合' do
      before { sign_in user }

      it '商品出品ページが表示される' do
        get new_item_path
        expect(response).to have_http_status(:success)
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        get new_item_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST /items' do
    context 'ログインしている場合' do
      before { sign_in user }

      context '有効なパラメータの場合' do
        it '商品が作成される' do
          expect {
            post items_path, params: { item: valid_attributes }
          }.to change(Item, :count).by(1)
        end

        it 'トップページにリダイレクトされる' do
          post items_path, params: { item: valid_attributes }
          expect(response).to redirect_to(root_path)
        end
      end

      context '無効なパラメータの場合' do
        it '商品が作成されない' do
          expect {
            post items_path, params: { item: invalid_attributes }
          }.not_to change(Item, :count)
        end

        it '出品ページが再表示される' do
          post items_path, params: { item: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end

        it 'エラーメッセージが表示される' do
          post items_path, params: { item: invalid_attributes }
          expect(response.body).to include('入力内容にエラーがあります')
        end
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        post items_path, params: { item: valid_attributes }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE /items/:id' do
    let!(:item) { create(:item, user: user) }

    context 'ログインしている場合' do
      before { sign_in user }

      it '商品が削除される' do
        expect {
          delete item_path(item)
        }.to change(Item, :count).by(-1)
      end

      it 'トップページにリダイレクトされる' do
        delete item_path(item)
        expect(response).to redirect_to(root_path)
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        delete item_path(item)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context '他のユーザーの商品の場合' do
      let(:other_user) { create(:user) }
      let!(:other_item) { create(:item, user: other_user) }

      before { sign_in user }

      it 'トップページにリダイレクトされる' do
        delete item_path(other_item)
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
