class AddNotNullToUsers < ActiveRecord::Migration[7.1]
  def up
    # カラムが存在するかをチェックしてから処理を実行
    if column_exists?(:users, :nickname)
      User.where(nickname: nil).update_all(nickname: "guest")
      change_column_null :users, :nickname, false
    end
    
    if column_exists?(:users, :last_name)
      User.where(last_name: nil).update_all(last_name: "guest")
      change_column_null :users, :last_name, false
    end
    
    if column_exists?(:users, :first_name)
      User.where(first_name: nil).update_all(first_name: "guest")
      change_column_null :users, :first_name, false
    end
    
    if column_exists?(:users, :last_name_kana)
      User.where(last_name_kana: nil).update_all(last_name_kana: "ゲスト")
      change_column_null :users, :last_name_kana, false
    end
    
    if column_exists?(:users, :first_name_kana)
      User.where(first_name_kana: nil).update_all(first_name_kana: "ゲスト")
      change_column_null :users, :first_name_kana, false
    end
    
    if column_exists?(:users, :birthday)
      User.where(birthday: nil).update_all(birthday: Date.today)
      change_column_null :users, :birthday, false
    end
  end

  def down
    change_column_null :users, :nickname, true if column_exists?(:users, :nickname)
    change_column_null :users, :last_name, true if column_exists?(:users, :last_name)
    change_column_null :users, :first_name, true if column_exists?(:users, :first_name)
    change_column_null :users, :last_name_kana, true if column_exists?(:users, :last_name_kana)
    change_column_null :users, :first_name_kana, true if column_exists?(:users, :first_name_kana)
    change_column_null :users, :birthday, true if column_exists?(:users, :birthday)
  end
end



