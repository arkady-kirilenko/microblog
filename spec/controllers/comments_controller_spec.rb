require 'rails_helper'

RSpec.describe CommentsController, type: :controller do

  describe "POST #create" do
    it "creates a comment with valid params" do
      params = { :author => "author", :content => "la le li le lo", :post_id => 1}
      expect{post :create, :comment => params }.to change{Comment.count}.by(1)
      expect(response).to have_http_status(:redirect)
    end

    it "does not create a comment with invalid params" do
      params = { :author => "", :content => "", :post_id => 1}
      expect{post :create, :comment => params}.to change{Comment.count}.by(0)
      expect(response).to have_http_status(:redirect)
    end
  end

  describe "routing" do
    it { expect(:get => "/comments").to_not be_routable}
    it { expect(:get => "/comments/1").to_not be_routable}
    it { expect(:get => "/comments/new").to_not be_routable}
    it { expect(:post => "/comments").to route_to("comments#create")}
    it { expect(:get => "/comments/1/edit").to_not be_routable}
    it { expect(:put => "/comments/1").to_not be_routable}
    it { expect(:delete => "/comments/1").to_not be_routable}
  end

end
