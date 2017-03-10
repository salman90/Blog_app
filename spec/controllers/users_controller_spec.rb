require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let (:user) { FactoryGirl.create(:user) }
  describe "#new" do
    context "with valid user and post" do
      it "responds successfully with an HTTP 200 status code" do
        get :new
        expect(response).to be_success
      end
      it "renders the new template" do
        get :new
        expect(response).to render_template("new")
      end
      it "assigns the user instance varabile" do
        get :new
        expect(assigns(:user)).to be_a_new(User)
      end
    end
  end
  describe "#create" do
    before {request.session[:user_id] = user.id}
    let(:valid_user_attributes) {FactoryGirl.attributes_for(:user)}
    let(:invalid_user_attributes) {FactoryGirl.attributes_for(:user).merge(first_name: nil)}
    context "with valid user attribute" do
      it "create a record in the database" do
        before_count  = User.count
        post :create, user: valid_user_attributes
        after_count = User.count
        expect(after_count).to eq(before_count + 1)
      end
      it "sets the sesion id user_id with the created user" do
        post :create, user: valid_user_attributes
        expect(session[:user_id]).to eq(User.last.id)
      end
      it "redirect to home page" do
        post :create, user: valid_user_attributes
        expect(response).to redirect_to(root_path)
      end
      it "sets flash message" do
        post :create, user: valid_user_attributes
        expect(flash[:notice]).to be
      end
    end
    context "with invalid request" do
      it "doesn't add a record to database" do
        count_before = User.count
        post :create, user: invalid_user_attributes
        count_after = User.count
        expect(count_before).to eq(count_after)
      end
      it "will render the new page" do
        post :create, user: invalid_user_attributes
        expect(response).to render_template("new")
      end
    end
  end
end
