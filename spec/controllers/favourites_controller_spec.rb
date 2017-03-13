require 'rails_helper'

RSpec.describe FavouritesController, type: :controller do
  let (:user) {FactoryGirl.create(:user)}
  describe "#create" do
    before {request.session[:user_id] = user.id}
    let(:post1) {FactoryGirl.create(:post)}
    let(:valid_favourite_attributes) {FactoryGirl.attributes_for(:favourite)}
    let (:invalid_favourite_attributes) {FactoryGirl.attributes_for(:favourite)}
    context "with valid request" do
      it "creates a favourite record in the database" do
         before_action = Favourite.count
         post :create, post_id: post1.id ,favourite: :valid_favourite_attributes
         after_action = Favourite.count
         expect(after_action).to eq(before_action + 1)
      end
      it "it redirect to the post show page" do
        post :create, post_id: post1.id ,favourite: :valid_favourite_attributes
        expect(response).to redirect_to(post_path(post1))
      end
      it "sets a flash notice to the user" do
        post :create, post_id: post1.id ,favourite: :valid_favourite_attributes
        expect(flash[:notice]).to be
      end
      it "associates the user with favourite" do
        post :create, post_id: post1.id ,favourite: :valid_favourite_attributes
        expect(Favourite.last.user).to eq(user)
      end
      it "associates the post with the favourites" do
        post :create, post_id: post1.id ,favourite: :valid_favourite_attributes
        expect(Favourite.last.post).to eq(post1)
      end
    end
    context "with invalid request" do
      before {request.session[:user_id] = nil}

      it "won't add a record in the database" do
        before_action = Favourite.count
        post :create, post_id:  post1, favourite: :invalid_favourite_attributes
        after_action = Favourite.count
        expect(after_action).to eq(before_action)
      end
      it "will redirect to the login page" do
        post :create, post_id:  post1, favourite: :invalid_favourite_attributes
        expect(response).to redirect_to(new_session_path)
      end
    end
  end
  describe "#destroy" do
    let!(:post) {FactoryGirl.create(:post)}
    let!(:favourite) {FactoryGirl.create(:favourite, user: user)}
    before {request.session[:user_id] = user.id}
    it "will remove a record from the database" do
      before_action = Favourite.count
      delete :destroy, id: favourite.id, post_id: post.id
      after_action = Favourite.count
      expect(before_action).to eq(after_action + 1)
    end
    it "will render the post show page" do
      delete :destroy, id: favourite.id, post_id: post.id
      expect(response).to redirect_to(post_path(post))
    end
  end
end
