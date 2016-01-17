require "rails_helper"

RSpec.describe StaticController, type: :controller do

  it "renders the home template" do
    get :home

    expect(response).to have_http_status(:ok)
    expect(response).to render_template(:home)
  end

  context "routing" do
    it { expect(:get => "/").to route_to("static#home")}

    context "route helpers" do
      it { expect(root_path).to eq("/")}
    end
  end
end
