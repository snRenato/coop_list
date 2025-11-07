# O ListsController gerencia as ações de CRUD (Criar, Ler, Atualizar, Deletar)
# para o recurso List (Listas). Ele usa Pundit para autorização.
class ListsController < ApplicationController
  # === FILTERS (CALLBACKS) ===

  # 1. (Devise) Garante que o usuário esteja logado antes de qualquer ação.
  before_action :authenticate_user!

  # 2. Carrega a @list específica do banco de dados para as ações que precisam dela.
  # Usa o :id da URL (ex: /lists/1)
  before_action :set_list, only: %i[show update destroy]

  # 3. (Pundit) Garante que a ação `authorize @list` foi chamada em todas as
  # actions, exceto :index. Se esquecermos, ele dará um erro.
  after_action :verify_authorized, except: :index

  # 4. (Pundit) Garante que o `policy_scope` foi usado na action :index.
  after_action :verify_policy_scoped, only: :index

  # === ACTIONS (AÇÕES) ===

  # GET /lists
  # Exibe todas as listas que o usuário atual tem permissão para ver.
  def index
    # `policy_scope(List)` usa a `ListPolicy::Scope` para filtrar as listas.
    # (ex: retorna apenas listas que o usuário criou ou é membro).
    @lists = policy_scope(List)
  end

  # GET /lists/:id
  # Exibe os detalhes de uma lista específica.
  def show
    # `set_list` já carregou @list.
    # `authorize @list` verifica se o current_user pode :show? esta @list.
    authorize @list
  end

  # GET /lists/new
  # Exibe o formulário para criar uma nova lista.
  def new
    @list = List.new
    # `authorize @list` verifica se o current_user pode :create? uma nova lista.
    authorize @list
  end

  # POST /lists
  # Recebe os dados do formulário (de 'new') e cria a lista no banco.
  def create
    @list = List.new(list_params)

    # Define o usuário logado como o dono (owner) da lista.
    @list.owner = current_user

    # Verifica se o usuário pode :create? este objeto @list (com o owner já setado).
    authorize @list

    if @list.save
      respond_to do |format|
        format.html { redirect_to lists_path, notice: "Lista criada com sucesso!" }
        format.json { render json: @list, status: :created }
      end
    else
      # Se a validação falhar (ex: título em branco), re-exibe o formulário 'new'.
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lists/:id
  # Recebe dados (geralmente JSON) para atualizar uma lista existente.
  def update
    # `set_list` já carregou @list.
    # `authorize @list` verifica se o usuário pode :update? esta @list.
    authorize @list

    if @list.update(list_params)
      # Esta ação parece ser usada para uma API ou edição in-loco (ex: JavaScript).
      render json: @list, status: :ok
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/:id
  # Exclui uma lista do banco de dados.
  def destroy
    # `set_list` já carregou @list.
    # `authorize @list` verifica se o usuário pode :destroy? esta @list.
    authorize @list

    @list.destroy

    respond_to do |format|
      # Remove o item da lista usando Turbo Stream (ex: <div id="list_1">...</div>)
      format.turbo_stream
      # Fallback para quem não usa JS ou para outros casos.
      format.html { redirect_to lists_path, notice: "Lista excluída com sucesso." }
    end
  end

  # === MÉTODOS PRIVADOS ===
  private

  # Método DRY (Don't Repeat Yourself) para carregar a lista
  # correta antes das ações `show`, `update`, e `destroy`.
  def set_list
    @list = List.find(params[:id])
  end

  # Strong Parameters: Define quais parâmetros são permitidos ao
  # criar ou atualizar uma lista. Isso previne Mass Assignment.
  def list_params
    params.require(:list).permit(:title)
  end
end
