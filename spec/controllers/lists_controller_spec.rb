require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:list) { create(:list, owner: user) }
  let!(:member_list) { create(:list, owner: other_user) }

  before do
    member_list.members.create(user: user, status: "accepted")
  end

  describe "GET #index" do
    context "quando não autenticado" do
      it "redireciona para login" do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "quando autenticado" do
      before { sign_in user }
      it "retorna apenas listas do usuário e das listas que é membro" do
  get :index
  expect(response).to have_http_status(:ok)

  # Testa se as listas corretas estão atribuídas
  expect(assigns(:lists)).to include(list, member_list)

  # Testa se listas de outros usuários que não são membros não estão incluídas
  other_list = create(:list, owner: create(:user))
  expect(assigns(:lists)).not_to include(other_list)
end
end
  end

  describe "GET #show" do
    context "quando é dono" do
      before { sign_in user }
      it "permite visualizar a lista" do
        get :show, params: { id: list.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context "quando é membro" do
      before { sign_in user }

      it "permite visualizar a lista" do
        get :show, params: { id: member_list.id }
        expect(response).to have_http_status(:ok)
      end
    end

    context "quando não autorizado" do
  before { sign_in other_user }

  it "retorna forbidden" do
    get :show, params: { id: list.id }
    expect(response).to have_http_status(:forbidden)
  end
end
  end

  describe "POST #create" do
    before { sign_in user }

    context "com params válidos" do
      it "cria uma lista" do
        expect {
          post :create, params: { list: { title: "Nova Lista" } }, format: :json
        }.to change(List, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "com params inválidos" do
      it "não cria a lista" do
        expect {
          post :create, params: { list: { title: "" } }, format: :json
        }.not_to change(List, :count)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH #update" do
    context "quando dono" do
      before { sign_in user }

      it "atualiza a lista" do
        patch :update, params: { id: list.id, list: { title: "Atualizada" } }, format: :json
        expect(response).to have_http_status(:ok)
        expect(list.reload.title).to eq("Atualizada")
      end
    end

    context "quando não dono e não membro autorizado" do
      before { sign_in other_user }

      it "retorna forbidden" do
        patch :update, params: { id: list.id, list: { title: "Atualizada" } }, format: :json
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "DELETE #destroy" do
    context "quando dono" do
      before { sign_in user }

      it "exclui a lista" do
        expect {
          delete :destroy, params: { id: list.id }, format: :turbo_stream
        }.to change(List, :count).by(-1)
        expect(response).to have_http_status(:ok)
      end
    end

    context "quando não dono" do
      before { sign_in other_user }

      it "não permite excluir" do
        expect {
          delete :destroy, params: { id: list.id }, format: :turbo_stream
        }.not_to change(List, :count)
        expect(response).to have_http_status(:forbidden)
      end
    end
  end
end
