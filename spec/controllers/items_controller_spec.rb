require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  include Devise::Test::ControllerHelpers

  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:unauthorized_user) { create(:user) }
  let(:list) { create(:list, owner: user) }
  let!(:member) { list.members.create!(user: other_user, status: "active") }
  let!(:item) { create(:item, list: list, name: "Item Original", status: false) }

  # ⚡ Configuração global do Devise mapping
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #new" do
    context "usuário não autenticado" do
      it "redireciona para login" do
        get :new, params: { list_id: list.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  # ===========================
  # POST #create
  # ===========================
  describe "POST #create" do
    context "usuário dono" do
      before { sign_in user }

      it "cria item via turbo_stream" do
        expect {
          post :create, params: { list_id: list.id, item: { name: "Novo Item TS" } }, format: :turbo_stream
        }.to change { list.items.count }.by(1)

        expect(list.items.last.name).to eq("Novo Item TS")
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      end

      it "cria item via HTML e redireciona" do
        expect {
          post :create, params: { list_id: list.id, item: { name: "Novo Item HTML" } }, format: :html
        }.to change { list.items.count }.by(1)

        expect(list.items.last.name).to eq("Novo Item HTML")
        expect(response).to redirect_to(list_path(list))
        expect(flash[:notice]).to eq("Item adicionado!")
      end

      it "não cria item com params inválidos" do
        expect {
          post :create, params: { list_id: list.id, item: { name: "" } }, format: :html
        }.not_to change { list.items.count }

        expect(response).to redirect_to(list_path(list))
        expect(flash[:alert]).to be_present
      end
    end

    context "usuário membro ativo" do
      before { sign_in other_user }

      it "permite criar item" do
        expect {
          post :create, params: { list_id: list.id, item: { name: "Item do Membro" } }, format: :html
        }.to change { list.items.count }.by(1)

        expect(response).to redirect_to(list_path(list))
        expect(flash[:notice]).to eq("Item adicionado!")
      end
    end
  end

  # ===========================
  # PATCH #toggle
  # ===========================
  describe "PATCH #toggle" do
    context "usuário dono" do
      before { sign_in user }

      it "alterna o status e responde em turbo_stream" do
        expect(item.status).to be false

        patch :toggle, params: { list_id: list.id, id: item.id }, format: :turbo_stream

        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
        expect(item.reload.status).to be true
      end
    end
  end
end
