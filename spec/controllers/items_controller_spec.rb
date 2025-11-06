require 'rails_helper'

RSpec.describe ItemsController, type: :controller do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:list) { create(:list, owner: user) }
  let!(:member) { list.members.create!(user: other_user, status: "active") }
  let!(:item) { create(:item, list: list, name: "Item Original", status: false) }

  # Configuração Devise
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "GET #new" do
    before { sign_in user }

    it "inicializa um novo item" do
      get :new, params: { list_id: list.id }
      expect(assigns(:item)).to be_a_new(Item)
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST #create" do
    context "usuário dono ou membro ativo" do
      before { sign_in user }

      it "cria item com formato turbo_stream" do
        post :create, params: { list_id: list.id, item: { name: "Novo Item", status: false } }, format: :turbo_stream
        expect(list.items.last.name).to eq("Novo Item")
        expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      end

      it "cria item com formato html" do
        post :create, params: { list_id: list.id, item: { name: "Novo Item", status: false } }, format: :html
        expect(list.items.last.name).to eq("Novo Item")
        expect(response).to redirect_to(list_path(list))
      end

      it "não cria item com params inválidos" do
        post :create, params: { list_id: list.id, item: { name: "" } }, format: :html
        expect(list.items.count).to eq(1) # só o item original existe
        expect(flash[:alert]).to be_present
        expect(response).to redirect_to(list_path(list))
      end
    end

    context "usuário não autorizado" do
      before { sign_in create(:user) } # usuário aleatório, não dono nem membro

      it "não permite criar item" do
        post :create, params: { list_id: list.id, item: { name: "Tentativa" } }, format: :html
        expect(response).to redirect_to(list_path(list))
      end
    end
  end

  describe "PATCH #toggle" do
    before { sign_in user }

    it "alterna o status do item" do
      expect(item.status).to be false
      patch :toggle, params: { list_id: list.id, id: item.id }, format: :turbo_stream
      expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      expect(item.reload.status).to eq(true)
    end
  end
end
