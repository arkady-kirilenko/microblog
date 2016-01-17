require 'rails_helper'
require 'helpers/posts_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::TestHelpers

  describe "GET #show" do
    it "fetches the correct post" do
      @post = create(:tagged_post)
      get :show, id: @post.slug

      expect(assigns(:post)).to eq(@post)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:show)
    end
  end

  describe "GET #index" do
    it "fetches all posts without category" do
      get :index

      expect(assigns(:posts).count).to eq(Post.count)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end

    it "fetches only the posts in the category" do
      tags = create_list(:tag, 3)
      @posts = create_list(:tagged_post, 10, tag: tags ).reverse

      get :index, category: tags.first.content

      expect(assigns[:posts]).to eq(@posts)
      expect(assigns[:posts]).to_not eq(Post.all)
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:index)
    end

  end

  describe "GET #new" do

      it "fetches the correct response when logged" do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        sign_in create(:admin)
        get :new

        expect(assigns(:post).to_json).to eql Post.new.to_json
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end

      it "redirects when not logged" do
        get :new
        expect(response).to have_http_status(:redirect)
        expect(response).to_not render_template(:new)
      end

  end

  describe "POST #create" do

    context "logged in" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        sign_in create(:admin)
      end
      context "with valid attributes" do
        it "creates new post" do
          expect{ post :create, {post: attributes_for(:post), tags: "teste"} }.to change{ Post.count }.by(1)
          expect(response).to have_http_status(:redirect)
        end

        it "creates post without tags" do
          expect{ post :create, {post: attributes_for(:post), tags: ""} }.to change{ Post.count }.by(1)
          expect(response).to have_http_status(:redirect)
        end

        it "creates new tags" do
          tags = build_list(:tag,3)
          expect{ post :create, {post: attributes_for(:post), tags: tags_to_s(tags)} }.to change{ Tag.count }.by(3)
          expect(response).to have_http_status(:redirect)
        end

        it "finds existing tags" do
          tags = create_list(:tag, 3)
          expect{ post :create, {post: attributes_for(:post), tags: tags_to_s(tags)} }.to change{ Tag.count }.by(0)
          expect(response).to have_http_status(:redirect)
        end
      end

      context "without valid attributes" do
        it "does not create a post" do
          expect{ post :create, {post: attributes_for(:invalid_post), tags: "teste"} }.to change{ Post.count }.by(0)
          expect(response).to render_template(:new)
          expect(response).to have_http_status(:ok)
        end

        it "does not create tags" do
          expect{ post :create, {post: attributes_for(:invalid_post), tags: "teste"} }.to change{ Tag.count }.by(0)
          expect(response).to render_template(:new)
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context "not logged" do
      context "with valid attributes" do
        it "creates new post" do
          expect{ post :create, {post: attributes_for(:post), tags: "teste"} }.to change{ Post.count }.by(0)
          expect(response).to have_http_status(:redirect)
        end

        it "creates new tags" do
          tags = build_list(:tag,3)
          expect{ post :create, {post: attributes_for(:post), tags: tags_to_s(tags)} }.to change{ Tag.count }.by(0)
          expect(response).to have_http_status(:redirect)
        end

        it "finds existing tags" do
          tags = create_list(:tag, 3)
          expect{ post :create, {post: attributes_for(:post), tags: tags_to_s(tags)} }.to change{ Tag.count }.by(0)
          expect(response).to have_http_status(:redirect)
        end
      end
    end
  end

  describe "GET #edit" do

    it "fetches the correct post when logged" do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in create(:admin)
      @post = create(:tagged_post)
      get :edit, id: @post.slug

      expect(assigns(:post)).to eql @post
      expect(response).to have_http_status(:ok)
      expect(response).to render_template(:edit)
    end

    it "redirects when not logged" do
      @post = create(:tagged_post)
      get :edit, id: @post.slug

      expect(assigns(:post)).to_not eql @post
      expect(response).to have_http_status(:redirect)
      expect(response).to_not render_template(:edit)
    end

  end

  describe "PUT #update" do

    context "logged in" do
      before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        sign_in create(:admin)
        @post = create(:post)
      end

      it "updates the post if valid params" do
        params = attributes_for(:post)
        put :update, :id => @post.id, :post => params
        expect(assigns(:post).title).to eql params[:title]
        expect(assigns(:post).body).to  eql params[:body]
        expect(response).to have_http_status(:redirect)
      end

      it "renders edit if invalid params" do
        put :update, :id => @post.id, :post => attributes_for(:invalid_post)
        expect(assigns[:post]).to eql @post
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end

    context "not logged in" do
      it "doest not change the post" do
        @post = create(:post)
        params = attributes_for(:post)
        put :update, :id => @post.id, :post => params
        expect(@post.title).to_not eql params[:title]
        expect(@post.body).to_not eql params[:body]
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "DELETE #destroy"do

    context "when logged in" do
      it "deletes the post" do
        @request.env["devise.mapping"] = Devise.mappings[:admin]
        sign_in create(:admin)
        @post = create(:post)

        expect { delete :destroy, :id => @post}.to change{Post.count}.by(-1)
        expect(response).to have_http_status(:redirect)
      end
    end

    context "when not logged in" do
      it "does not delete the post" do
        @post = create(:post)

        expect { delete :destroy, :id => @post}.to change{Post.count}.by(0)
        expect(response).to have_http_status(:redirect)
      end
    end

  end

  describe "routing" do
    it { expect(:get => "/blog/posts").to route_to("posts#index")}
    it { expect(:get => "/blog/posts/1").to route_to("posts#show", :id => "1")}
    it { expect(:get => "/blog/posts/new").to route_to("posts#new")}
    it { expect(:post => "/blog/posts/").to route_to("posts#create")}
    it { expect(:get => "/blog/posts/1/edit").to route_to("posts#edit", :id => "1")}
    it { expect(:put => "/blog/posts/1").to route_to("posts#update", :id => "1")}
    it { expect(:delete => "/blog/posts/1").to route_to("posts#destroy", :id => "1")}

    context "route helpers" do
      it { expect(post_path(1)).to eq("/blog/posts/1")}
      it { expect(posts_path).to eq("/blog/posts")}
    end
  end

end
