require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  let(:admin){
    FactoryGirl.create(:user, :admin)
  }

  let(:user){
    FactoryGirl.create(:user)
  }

  let(:admin_auth) {
    ActionController::HttpAuthentication::Basic.encode_credentials(admin.email, admin.password)
  }

  let(:user_auth){
    ActionController::HttpAuthentication::Basic.encode_credentials(user.email, user.password)
  }

  let(:user_attributes) {
    attributes_for(:user)
  }

  let(:invalid_attributes) {
    { name: 'Invalid User', email: 'invalid@domain' }
  }

  describe "GET #index" do
    it "assigns all users as @users" do
      user = User.create! user_attributes
      get :index, {}
      expect(assigns(:users)).to include(user)
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "assigns the requested user as @user" do
      user = User.create! user_attributes
      get :show, {:id => user.id}
      expect(assigns(:user)).to eq(user)
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "as administrator" do
      context "with valid params" do
        it "creates a new User" do
          expect {
            request.env['HTTP_AUTHORIZATION'] = admin_auth
            post :create, {:user => user_attributes}
          }.to change(User.user, :count).by(1)
        end

        it "assigns a newly created user as @user" do
          request.env['HTTP_AUTHORIZATION'] = admin_auth
          post :create, {:user => user_attributes}
          expect(assigns(:user)).to be_a(User)
          expect(assigns(:user)).to be_persisted
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved user as @user" do
          invalid_user = user_attributes.merge invalid_attributes
          request.env['HTTP_AUTHORIZATION'] = admin_auth
          post :create, {:user => invalid_user}
          expect(response).to have_http_status(422)
        end
      end
    end
  end

  describe "PUT #update" do
    context "as administrator" do
      context "with valid params" do
        let(:new_attributes) {
          {name: Faker::Name.name}
        }

        it "updates the requested user" do
          user = User.create! user_attributes
          request.env['HTTP_AUTHORIZATION'] = admin_auth
          put :update, {:id => user.id, :user => new_attributes}
          user.reload
          expect(user.name).to eq(new_attributes[:name])
        end

        it "assigns the requested user as @user" do
          user = User.create! user_attributes
          request.env['HTTP_AUTHORIZATION'] = admin_auth
          put :update, {:id => user.id, :user => user_attributes}
          expect(assigns(:user)).to eq(user)
        end
      end

      context "with invalid params" do
        it "assigns the user as @user" do
          user = User.create! attributes_for(:user)
          request.env['HTTP_AUTHORIZATION'] = admin_auth
          put :update, {:id => user.id, :user => invalid_attributes}
          expect(response).to have_http_status(422)
        end
      end
    end

    describe "DELETE #destroy" do
      context "as administrator" do
        it "destroys the requested user" do
          user = User.create! user_attributes
          request.env['HTTP_AUTHORIZATION'] = admin_auth
          expect {
            delete :destroy, {:id => user.to_param}
          }.to change(User.user, :count).by(-1)
        end
      end
    end
  end

end
