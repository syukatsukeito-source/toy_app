require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
  end

  test "layout links for logged-in user" do
    # 1. ヒントの通り、まずはログイン状態を作り出す！
    log_in_as(@user)
    
    # 2. 画面（今回はトップページ）を開く
    get root_path
    assert_template 'static_pages/home'
    
    # 3. ログイン済み専用のリンクが出現しているかチェック！
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path
    
    # 4. 逆に、Log in リンクがちゃんと「消えている（0個である）」こともチェック！
    assert_select "a[href=?]", login_path, count: 0
  end
end
