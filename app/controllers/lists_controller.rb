# O ListsController gerencia as ações de CRUD (Criar, Ler, Atualizar, Deletar)
# para o recurso List (Listas). Ele usa Pundit para autorização e agora utiliza
# FriendlyId para gerar URLs amigáveis com base no título da lista.
class ListsController < ApplicationController
  # === FILTERS (CALLBACKS) ===

  # 1. (Devise) Garante que o usuário esteja logado antes de qualquer ação.
  before_action :authenticate_user!

  # 2. Carrega a @list específica do banco de dados para as ações que precisam dela.
  # Usa o slug gerado pelo FriendlyId em vez do ID numérico.
  before_action :set_list, only: %i[show update destroy]

  # 3. (Pundit) Garante que a ação `authorize @list` foi chamada em todas as
  # actions, exceto :index. Se esquecermos, ele dará um erro.
  after_action :verify_authorized, except: :index

  # 4. (Pundit) Garante que o `policy_scope` foi usado na action :index.
  after_action :verify_policy_scoped, only: :index

  # === ACTIONS (AÇÕES) ===

  # GET /lists
  def index
    @lists = policy_scope(List)
  end

  # GET /lists/:id
  # Exibe os detalhes de uma lista específica (usando slug no lugar do id).
  def show
    authorize @list
  end

  # GET /lists/new
  def new
    @list = List.new
    authorize @list
  end

  # POST /lists
  def create
    @list = List.new(list_params)
    @list.owner = current_user
    authorize @list

    if @list.save
      respond_to do |format|
        format.html { redirect_to lists_path, notice: "Lista criada com sucesso!" }
        format.json { render json: @list, status: :created }
      end
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/:id
  def update
    authorize @list

    if @list.update(list_params)
      render json: @list, status: :ok
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/:id
  def destroy
    authorize @list
    @list.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to lists_path, notice: "Lista excluída com sucesso." }
    end
  end

  # === MÉTODOS PRIVADOS ===
  private

  # ⚡ Usa FriendlyId para buscar listas pelo slug em vez do ID numérico
  def set_list
    @list = List.friendly.find(params[:id])
  end

  # Strong Parameters
  def list_params
    params.require(:list).permit(:title)
  end
end
