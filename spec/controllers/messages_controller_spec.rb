require "rails_helper"

describe MessagesController, type: :controller do

  let(:user)     { create(:user) }
  let(:group)    { create(:group)}
  let(:groups)   { create_list(:group, 5, user_ids: user.id)}
  let(:message)  { create(:message, user_id: user, group_id: group)}
  let(:messages) { create_list(:message, 5, user_id: user, group_id: group)}

  describe "GET #index" do

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

  describe "post #create" do

    context "when user is signed in" do

      before do
        login_user user
      end

      context "and recording sccuesses" do

        it "saves a new message to the database" do
          message_params = attributes_for(:message)
          expect{ post :create, group_id: group, user_id: user, message:message_params }.to change(Message, :count).by(1)
        end

        it "generate a notice message on flash" do
          message_params = attributes_for(:message)
          post :create, group_id: group, user_id: user, message: message_params
          expect(flash[:notice]).to include("メッセージを投稿しました。")
        end

        it "redirects to messages#index after a message is saved" do
          message_params = attributes_for(:message)
          post :create, group_id: group, user_id: user, message: message_params
          expect(response).to redirect_to group_messages_path(group_id: group)
        end

      end

      context "and recording fails" do
        it "doesn't save a new message to the database" do
          message_params = attributes_for(:message, body: nil, image: nil)
          expect{ post :create, group_id: group, user_id: user, message: message_params}.to change(Message, :count).by(0)
        end

        it "generate an error message on flash" do
          message_params = attributes_for(:message, body: nil, image: nil)
          post :create, group_id: group, user_id: user, message: message_params
          expect(flash[:alert]).to include("テキストを入力するか画像を添付してください。")
        end

        it "redirects to messages#index after a message is saved" do
          message_params = attributes_for(:message, body: nil, image: nil)
          post :create, group_id: group, user_id: user, message: message_params
          expect(response).to redirect_to group_messages_path(group_id: group)
        end
      end

    end   #context "singed in"

    context "when user is not signed in" do

      it "redirects to devise/sessions#new when user is not signed in" do
        message_params = attributes_for(:message, body: nil, image: nil)
        post :create, group_id: group, user_id: user, message: message_params
        expect(response).to redirect_to new_user_session_path
      end

    end #context "not singed in"

  end     #post #create
end       #Message controller
