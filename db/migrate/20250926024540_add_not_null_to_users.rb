class AddNotNullToUsers < ActiveRecord::Migration[7.1]
  def up
    User.where(nickname: nil).update_all(nickname: "guest")
    User.where(last_name: nil).update_all(last_name: "guest")
    User.where(first_name: nil).update_all(first_name: "guest")
    User.where(last_name_kana: nil).update_all(last_name_kana: "ゲスト")
    User.where(first_name_kana: nil).update_all(first_name_kana: "ゲスト")
    User.where(birthday: nil).update_all(birthday: Date.today)

    change_column_null :users, :nickname, false
    change_column_null :users, :last_name, false
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name_kana, false
    change_column_null :users, :first_name_kana, false
    change_column_null :users, :birthday, false
  end

  def down
    change_column_null :users, :nickname, true
    change_column_null :users, :last_name, true
    change_column_null :users, :first_name, true
    change_column_null :users, :last_name_kana, true
    change_column_null :users, :first_name_kana, true
    change_column_null :users, :birthday, true
  end
end



