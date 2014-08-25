
require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'POST #create' do

    context 'with valid attributes' do

      before { post :create, user: Fabricate.attributes_for(:user) }

      after { ActionMailer::Base.deliveries.clear }

      it 'sets the @user instance variable' do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it 'creates a user in the database' do
        expect(User.count).to eq(1)
      end

      it 'redirects the user to the sign in path' do
        expect(response).to redirect_to signin_path
      end

      it 'responds with an HTTP 302 status code' do
        expect(response).to have_http_status(302)
      end

      it 'sends an email' do
        expect(ActionMailer::Base.deliveries).to_not be_empty
      end

      it 'sends an email to the correct recipient' do
        message = ActionMailer::Base.deliveries.last
        expect(message.to).to eq([User.first.email_address])
      end

      it 'sends an email with the correct content' do
        message = ActionMailer::Base.deliveries.last
        expect(message.body).to include("Welcome to MyFlix, #{User.first.full_name}!")
      end
    end

    context 'with invalid attributes' do

      before { post :create, user: Fabricate.attributes_for(:user, email_address: '') }

      after { ActionMailer::Base.deliveries.clear }

      it 'sets the @user instance variable' do
        expect(assigns(:user)).to be_instance_of(User)
      end

      it 'does not create a user in the database' do
        expect(User.first).to eq(nil)
      end

      it 'renders the users/new template' do
        expect(response).to render_template :new
      end

      it 'responds successfully' do
        expect(response).to be_success
      end

      it 'responds with an HTTP 200 status code' do
        expect(response).to have_http_status(200)
      end

      it 'does not send an email' do
        expect(ActionMailer::Base.deliveries).to be_empty
      end
    end
  end
end
