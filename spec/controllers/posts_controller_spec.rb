require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let (:user) { FactoryGirl.create(:user) }
  describe "#new" do
    before {request.session[:user_id] = user.id}
    it "responds successfully with an HTTP 200 status code" do
      get :new
      expect(response).to be_success
    end
    it "renders the new template" do
      get :new
        expect(response).to render_template("new")
    end
    it "assigns the post instance varabilre" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end
  describe "#create" do
    before {request.session[:user_id] = user.id}
    let(:valid_post_attributes) {FactoryGirl.attributes_for(:post)}
    let(:invalid_post_attributes) {FactoryGirl.attributes_for(:post).merge(body: nil)}
    context "with valid request" do
      it "save a record in the database" do
        before_action = Post.count
        post :create, post: valid_post_attributes
        after_action = Post.count
        expect(after_action).to eq(before_action + 1)
      end
      it "it redirect to show page" do
        post :create, post: valid_post_attributes
        expect(response).to redirect_to(post_path(Post.last))
      end
      it "sets flash message " do
        post :create, post: valid_post_attributes
        expect(flash[:notice]).to be
      end
    end
    context "with invaild request" do
      it "doesn't add a record to database" do
        before_action = Post.count
        post :create, post: invalid_post_attributes
        after_action = Post.count
        expect(after_action).to eq(before_action)
      end
      it "sets flash message" do
        post :create, post: invalid_post_attributes
        expect(flash[:alert]).to be
      end
      it "renders the new template" do
        post :create, post: invalid_post_attributes
        expect(response).to render_template("new")
      end
    end
  end
  describe "#show" do
    let (:post) { FactoryGirl.create(:post) }
    before do
       get :show, id: post.id
    end
    it "assigns a new Post to @post" do
      expect(assigns(:post)).to eq(post)
    end
    it "renders the show the template" do
      expect(response).to render_template("show")
    end
    it "assigns the comment to varabile @comment" do
    end
  end
  describe "#index" do
    let!(:post_1) {FactoryGirl.create(:post)}
    let!(:post_2) {FactoryGirl.create(:post)}
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
    it "sets @posts variable to all of the posts" do
      get :index
      expect(assigns(:posts)).to include(post_1, post_2)
    end
  end
  describe "#edit" do
    let (:post) { FactoryGirl.create(:post) }
    before {request.session[:user_id] = user.id}
    before do
      get :edit, id: post.id
    end
    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end
    it "sets the @post to post with id " do
      expect(assigns(:post)).to eq(post)
    end
  end
  describe "#update" do
    let (:post) { FactoryGirl.create(:post) }
    before {request.session[:user_id] = user.id}
    context "With valid attributes" do
      def valid_request
        patch :update, id: post.id, user_id: user, post: {title: "new valid title"}
      end
      it "update the record in the database" do
        valid_request
         expect(post.reload.title).to eq("new valid title")
      end
      it "redirect to show page" do
        valid_request
        expect(response).to redirect_to(post_path(post))
      end
      it "sets the flash" do
        valid_request
        expect(flash[:notice]).to be
      end
    end
    context "with invalid request attributes" do
      def invalid_request
        patch :update, id: post.id, post: {title: ""}
      end
      it "doesn't save the value on the database" do
        invalid_request
        expect(post.reload.title).to_not eq("")
      end
      it "renders the edit template" do
         invalid_request
         expect(response).to render_template(:edit)
      end
      it "sets the flash" do
        invalid_request
        expect(flash[:alert]).to be
      end
    end
  end
  describe "#destroy" do
    let!(:post) { FactoryGirl.create(:post) }
    before {request.session[:user_id] = user.id}
    it "removes the record from the database" do
      count_before = Post.count
      delete :destroy, id: post.id
      count_after = Post.count
      expect(count_before).to eq(count_after + 1 )
    end
    it "redirects to posts_path" do
      delete :destroy, id: post.id
      expect(response).to redirect_to(posts_path)
    end
  end
end
