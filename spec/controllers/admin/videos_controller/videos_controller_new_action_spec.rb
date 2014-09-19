
require 'rails_helper'

RSpec.describe Admin::VideosController, type: :controller do

  describe 'GET #new' do

    it_behaves_like 'requires user' do
      let(:action) { get :new }
    end

    context 'with an admin user' do

      before :each do
        set_current_admin
        get :new
      end

      it 'sets the @video instance variable' do
        expect(assigns(:video)).to be_new_record
      end

      it 'creates an instance of the Video class' do
        expect(assigns(:video)).to be_instance_of(Video)
      end

      it 'renders the admin/videos/new template' do
        expect(response).to render_template :new
      end

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'responds with an HTTP 200 status code' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with a non-admin user' do

      before :each do
        set_current_user
        get :new
      end

      it 'redirects the user to the home path' do
        expect(response).to redirect_to home_path
      end

      it 'flashes a danger alert' do
        expect(flash[:danger]).to be_present
      end
    end
  end
end
