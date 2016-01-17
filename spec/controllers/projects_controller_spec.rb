require "rails_helper"

RSpec.describe ProjectsController, type: :controller do

  context "when logged in" do
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in create(:admin)
    end

    describe "GET #show" do
      it "fetches the correct project" do
        @project = create(:project)
        get :show, :id => @project.slug
        expect(assigns[:project]).to eql @project
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:show)
      end
    end

    describe "GET #index" do
      it "fetches all the projects" do
        get :index
        expect(assigns[:projects].count).to eql Project.count
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end

    describe "GET #new" do
      it "sets a new project" do
        get :new
        expect(assigns[:project].to_json).to eql Project.new.to_json
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end

    describe "POST #create" do
      it "saves a project with valid params" do
        expect{ post :create, {project: attributes_for(:project), tags: "teste"} }.to change{ Project.count }.by(1)
        expect(response).to have_http_status(:redirect)
      end

      it "doest not save a project with invalid params" do
        expect{post :create, :project => attributes_for(:invalid_project)}.to change{Project.count}.by(0)
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:new)
      end
    end

    describe "GET #edit" do
      it "sets the correct project" do
        @project = create(:project)
        get :edit, :id => @project.slug
        expect(assigns[:project]).to eql @project
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end

    describe "PUT #update" do
      before(:each) { @project = create(:project)}

      it "updates the project if valid params" do
        params = attributes_for(:project)
        put :update, :id => @project.slug, :project => params
        expect(assigns[:project].title).to eql params[:title]
        expect(assigns[:project].description).to eql params[:description]
        expect(assigns[:project].project_url).to eql params[:project_url]
        expect(assigns[:project].github_url).to eql params[:github_url]
        expect(response).to have_http_status(:redirect)
      end

      it "doest not update the project if invalid params" do
        put :update, :id => @project.slug, :project => attributes_for(:invalid_project)
        expect(assigns[:project]).to eql @project
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:edit)
      end
    end

    describe "DELETE #destroy" do
      it "deletes the project" do
        @project = create(:project)
        expect { delete :destroy, :id => @project.slug }.to change{Project.count}.by(-1)
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  context "when not logged in" do
    describe "GET #show" do
      it "fetches the correct project" do
        @project = create(:project)
        get :show, :id => @project.slug
        expect(assigns[:project]).to eql @project
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:show)
      end
    end

    describe "GET #index" do
      it "fetches all the projects" do
        get :index
        expect(assigns[:projects].count).to eql Project.count
        expect(response).to have_http_status(:ok)
        expect(response).to render_template(:index)
      end
    end

    describe "GET #new" do
      it "redirects to login" do
        get :new
        expect(assigns[:project]).to eql nil
        expect(response).to have_http_status(:redirect)
      end
    end

    describe "POST #create" do
      it "redirects to login" do
        expect{post :create, project: attributes_for(:project)}.to change{Project.count}.by(0)
        expect(response).to have_http_status(:redirect)
      end
    end

    describe "GET #edit" do
      it "redirects to login" do
        @project = create(:project)
        get :edit, id: @project.slug
        expect(assigns[:project]).to eql nil
        expect(response).to have_http_status(:redirect)
      end
    end

    describe "PUT #update" do
      it "redirects to login" do
        @project = create(:project)
        params = attributes_for(:project)
        put :update, :id => @project.id, :project => params
        expect(@project.title).to_not eql params[:title]
        expect(@project.description).to_not eql params[:description]
        expect(response).to have_http_status(:redirect)
      end
    end

    describe "DELETE #destroy" do
      it "redirects to login" do
        @project = create(:project)
        expect{delete :destroy, id: @project.slug}.to change{Project.count}.by(0)
        expect(response).to have_http_status(:redirect)
      end
    end
  end

  describe "routing" do
    it { expect(:get => "/projects").to route_to("projects#index")}
    it { expect(:get => "/projects/1").to route_to("projects#show", :id => "1")}
    it { expect(:get => "/projects/new").to route_to("projects#new")}
    it { expect(:post => "/projects/").to route_to("projects#create")}
    it { expect(:get => "/projects/1/edit").to route_to("projects#edit", :id => "1")}
    it { expect(:put => "/projects/1").to route_to("projects#update", :id => "1")}
    it { expect(:delete => "/projects/1").to route_to("projects#destroy", :id => "1")}

    context "route helpers" do
      it { expect(project_path(1)).to eq("/projects/1")}
      it { expect(projects_path).to eq("/projects")}
    end
  end
end
