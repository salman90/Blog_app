require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let (:user) { FactoryGirl.create(:user) }
  describe "#create" do
    before {request.session[:user_id] = user.id}
    let(:post1) { FactoryGirl.create(:post) }
    let(:valid_comment_attributes) {FactoryGirl.attributes_for(:comment)}
    let(:invalid_comment_attributes) {FactoryGirl.attributes_for(:comment).merge({body: ""})}
    context "with valid request" do
      it "creates a comment in the database" do
        count_before = Comment.count
        post :create, post_id: post1.id ,comment: valid_comment_attributes
        count_after = Comment.count
        expect(count_after).to eq(count_before + 1)
      end
      it "associates the post with comments" do
        post :create, post_id: post1.id, comment: valid_comment_attributes
        expect(Comment.last.post).to eq(post1)
      end
      it "associates the user with comments" do
        post :create, post_id: post1.id, comment: valid_comment_attributes
        expect(Comment.last.user).to eq(user)
      end
      it "redirect to the post show page" do
         post :create, post_id: post1.id, comment: valid_comment_attributes
         expect(response).to redirect_to(post_path(post1))
      end
      it "sets the flash" do
        post :create, post_id: post1.id, comment: valid_comment_attributes
        expect(flash[:notice]).to be
      end
    end
    context "with invaild request" do
      it "doesn't create a record in database" do
        before_action = Comment.count
        post :create, post_id: post1.id, comment: invalid_comment_attributes
        after_action = Comment.count
        expect(before_action).to eq(after_action)
      end
      it "renders the post show page" do
        post :create, post_id: post1.id, comment: invalid_comment_attributes
        expect(response).to render_template('posts/show')
      end
      it "sets the flash" do
        post :create, post_id: post1.id, comment: invalid_comment_attributes
        expect(flash[:alert]).to be
      end
    end
  end
  describe "#edit" do
    before {request.session[:user_id] = user.id}
    let(:post) { FactoryGirl.create(:post) }
    let(:comment) {FactoryGirl.create(:comment)}
    before do
      get :edit, id: comment.id, post_id: post.id
    end
    
  end
end
