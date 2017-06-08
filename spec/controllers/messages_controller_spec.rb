require 'rails_helper'

describe MessagesController, type: :controller do

  let(:user)     { create(:user) }
  let(:group)    { create(:group)}
  let(:groups)   { create_list(:group, 5, user_ids: user.id)}
  let(:messages) { create_list(:message, 5, user_id: user, group_id: group)}

  describe 'GET #index' do

    context "when user is signed in" do
      before do
        login_user user
      end

      it "assigns a blank message to @message" do
        get :index, group_id: group
        expect(assigns(:message)).to be_a_new(Message)
      end

      it "assigns the requested group to @group" do
        get :index, group_id: group
        expect(assigns(:group)).to eq group
      end

      it "populates an array of groups" do
        get :index, group_id: group
        expect(assigns(:groups)).to match(groups)
      end

      it "renders the :index template" do
        get :index, group_id: group
        expect(response).to render_template :index
      end
    end

    context "When user is not signed in" do
      it "redirects to devise/sessions#new when user is not signed in" do
        get :index, group_id: group
        expect(response).to redirect_to new_user_session_path
      end

    end   #context "user not singed in"
  end     #Get #index
end       #Message controller


# メッセージ一覧ページを表示するアクション

# ログインしている場合
# アクション内で定義しているインスタンス変数があるか OK
# 該当するビューが描画されているか OK

# ログインしていない場合
# 意図したビューにリダイレクトできているか


# メッセージを作成するアクション
# ログインしているかつ、保存に成功した場合
# メッセージの保存はできたのか
# 意図した画面に遷移しているか
# ログインしているが、保存に失敗した場合
# メッセージの保存は行われなかったか
# 該当するインスタンス変数はあるか
# 意図したビューが描画されているか
# ログインしていない場合
# 意図した画面にリダイレクトできているか ### MessagesControllerのテスト テストするべき項目は自身のmessages_controller.rbの中にあります。 自身で書いたコードをよく読み、どのようなテストが必要になるか考えて洗い出してみましょう。 コントローラのテストでは、以下のようなポイントをテストします。
