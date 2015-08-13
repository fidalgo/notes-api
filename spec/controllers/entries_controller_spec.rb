require 'rails_helper'


RSpec.describe Api::V1::EntriesController, type: :controller do

  let(:invalid_attributes) {
    { line: '' }
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
    it "assigns all entries as @entries" do
      entry = Entry.create! build(:entry).attributes
      get :index, {note_id: entry.note.id}
      expect(assigns(:entries)).to eq([entry])
    end
  end

  describe "GET #show" do
    it "assigns the requested entry as @entry" do
      entry = Entry.create! build(:entry).attributes
      get :show, {id: entry.id, note_id: entry.note.id}
      expect(assigns(:entry)).to eq(entry)
    end
  end

  describe "POST #create" do
    context "as user" do
      context "with valid params" do
        it "creates a new Entry" do
          expect {
            note = create(:note)
            request.env['HTTP_AUTHORIZATION'] = user_auth
            post :create, {entry: build(:entry).attributes, note_id: note.id}
          }.to change(Entry, :count).by(1)
        end

        it "assigns a newly created entry as @entry" do
          note = create(:note)
          request.env['HTTP_AUTHORIZATION'] = user_auth
          post :create, {entry: build(:entry).attributes, note_id: note.id}
          expect(assigns(:entry)).to be_a(Entry)
          expect(assigns(:entry)).to be_persisted
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved entry as @entry" do
          entry_attributes = build(:entry).attributes
          request.env['HTTP_AUTHORIZATION'] = user_auth
          post :create, {entry: entry_attributes.merge(invalid_attributes), note_id: entry_attributes['note_id']}
          expect(response).to have_http_status(422)
        end
      end
    end
  end

  describe "PUT #update" do
    context "as administrator" do
      context "with valid params" do
        let(:new_attributes) {
          {line: "A totally new line" }
        }

        it "updates the requested entry" do
          entry = Entry.create! build(:entry).attributes
          request.env['HTTP_AUTHORIZATION'] = admin_auth
          put :update, {id: entry.to_param, entry: new_attributes, note_id: entry.note.id}
          entry.reload
          expect(entry.line).to eq(new_attributes[:line])
        end

        it "assigns the requested entry as @entry" do
          entry = Entry.create! build(:entry).attributes
          request.env['HTTP_AUTHORIZATION'] = admin_auth
          put :update, {id: entry.to_param, entry: new_attributes, note_id: entry.note.id}
          expect(assigns(:entry)).to eq(entry)
        end
      end

      context "with invalid params" do
        it "assigns the entry as @entry" do
          entry = Entry.create! build(:entry).attributes
          request.env['HTTP_AUTHORIZATION'] = admin_auth
          put :update, {id: entry.to_param, entry: invalid_attributes, note_id: entry.note.id}
          expect(assigns(:entry)).to eq(entry)
        end
      end
    end
  end

  describe "DELETE #destroy" do
    context "as administrator" do
      it "destroys the requested entry" do
        entry = Entry.create! build(:entry).attributes
        expect {
          request.env['HTTP_AUTHORIZATION'] = admin_auth
          delete :destroy, {id: entry.to_param, note_id: entry.note.id}
        }.to change(Entry, :count).by(-1)
      end
    end

    context "as user" do
      it "destroys the requested entry" do
        note = build(:note, user: user)
        entry = create(:entry, note: note)
        request.env['HTTP_AUTHORIZATION'] = user_auth
        expect {
          delete :destroy, {id: entry.to_param, note_id: entry.note.id}
        }.to change(Entry, :count).by(-1)
      end
    end

  end

end
