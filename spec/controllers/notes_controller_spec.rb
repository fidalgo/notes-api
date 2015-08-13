require 'rails_helper'

RSpec.describe Api::V1::NotesController, type: :controller do

  let(:valid_attributes) {
    user = create(:user)
    {title: "Fancy Note title", user: user }
  }

  let(:invalid_attributes) {
    {title: nil }
  }

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

  describe "GET #index" do
    it "assigns all notes as @notes" do
      note = Note.create! attributes_for(:note)
      get :index, {}
      expect(assigns(:notes)).to eq([note])
    end
  end

  describe "GET #show" do
    it "assigns the requested note as @note" do
      note = Note.create! valid_attributes
      get :show, {:id => note.to_param}
      expect(assigns(:note)).to eq(note)
    end
  end

  describe "POST #create" do
    context "as user" do
      context "with valid params" do
        it "creates a new Note" do
          request.env['HTTP_AUTHORIZATION'] = user_auth
          expect {
            post :create, {:note => valid_attributes}
          }.to change(Note, :count).by(1)
        end

        it "assigns a newly created note as @note" do
          request.env['HTTP_AUTHORIZATION'] = user_auth
          post :create, {:note => valid_attributes}
          expect(assigns(:note)).to be_a(Note)
          expect(assigns(:note)).to be_persisted
        end

        it "renders the created note" do
          request.env['HTTP_AUTHORIZATION'] = user_auth
          post :create, {:note => valid_attributes}
          expect(response.body).to eq(Note.last.to_json)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved note as @note" do
          request.env['HTTP_AUTHORIZATION'] = user_auth
          post :create, {:note => invalid_attributes}
          expect(response).to have_http_status(422)
        end
      end
    end
  end

  describe "PUT #update" do
    context "as administrator" do
      context "with valid params" do
        let(:new_attributes) {
          {title: "New Note title" }
        }

        it "updates the requested note" do
          note = Note.create! valid_attributes
          request.env['HTTP_AUTHORIZATION'] = admin_auth
          put :update, {:id => note.to_param, :note => new_attributes}
          note.reload
          expect(note.title).to eq(new_attributes[:title])
        end

        it "assigns the requested note as @note" do
          note = Note.create! valid_attributes
          request.env['HTTP_AUTHORIZATION'] = admin_auth
          put :update, {:id => note.to_param, :note => valid_attributes}
          expect(assigns(:note)).to eq(note)
        end
      end

      context "with invalid params" do
        it "assigns the note as @note" do
          note = Note.create! valid_attributes
          request.env['HTTP_AUTHORIZATION'] = admin_auth
          put :update, {:id => note.to_param, :note => invalid_attributes}
          expect(assigns(:note)).to eq(note)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "as user" do
      it "destroys the requested note" do
        note_attributes = build(:note, user: user).attributes
        note = Note.create! note_attributes
        request.env['HTTP_AUTHORIZATION'] = user_auth
        expect {
          delete :destroy, {:id => note.to_param}
        }.to change(Note, :count).by(-1)
      end
    end

    context "as administrator" do
      it "destroys the requested note" do
        note = Note.create! valid_attributes
        request.env['HTTP_AUTHORIZATION'] = admin_auth
        expect {
          delete :destroy, {:id => note.to_param}
        }.to change(Note, :count).by(-1)
      end
    end

  end

end
