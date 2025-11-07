class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list
  before_action :set_item, only: [ :update ]
  before_action :authorize_manage_items!, only: [:new, :create, :update, :toggle]

  def new
    @item = Item.new
  end

  def create
    # set_list já deve ter sido chamado pelo before_action
    @item = @list.items.build(item_params)
    # autorização — se usar Pundit, substitua por `authorize @item` ou sua lógica
    authorize_manage_items!
    if @item.save
      respond_to do |format|
        # Resposta para Turbo Stream / frames (AJAX)
        format.turbo_stream do
          render turbo_stream: [
            # adiciona o novo item ao final do container #items_list
            turbo_stream.append("items_list", partial: "items/item", locals: { item: @item }),
            # atualiza o contador pendentes
            turbo_stream.replace("pending_count", partial: "lists/pending_count", locals: { list: @list })
          ]
        end

        # Fallback HTML (caso o navegador não use Turbo)
        format.html { redirect_to @list, notice: "Item adicionado!" }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          # substitui o form por uma versão com erros (partial que deve existir)
          render turbo_stream: turbo_stream.replace(
            "new_item",
            partial: "items/form",
            locals: { list: @list, item: @item }
          ), status: :unprocessable_entity
        end

        format.html do
          flash[:alert] = @item.errors.full_messages.to_sentence
          redirect_to @list
        end
      end
    end
  end

  def show
    @item = @list.items.find(params[:id])
  end

  def edit
    @item = @list.items.find(params[:id])
  end


  def update
    authorize_manage_items!
    if @item.update(item_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @list, notice: "Item atualizado!" }
      end
    else
      redirect_to @list, alert: @item.errors.full_messages.to_sentence
    end
  end

  def toggle
     @item = Item.find(params[:id])
  @item.update(status: !@item.status)

  respond_to do |format|
    format.turbo_stream do
      render turbo_stream: [
        turbo_stream.replace("items_list", partial: "items/items", locals: { items: @item.list.items }),
        turbo_stream.replace("pending_count", partial: "lists/pending_count", locals: { list: @item.list })
      ]
    end
    format.html { redirect_to @item.list }
  end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_item
    @item = @list.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :status)
  end

  def authorize_manage_items!
    # O dono da lista sempre pode
    return if @list.owner == current_user

    # Membros aceitos também podem
    member = @list.members.find_by(user: current_user, status: "accepted")
    return if member.present?

    # Qualquer outro usuário é bloqueado
    redirect_to root_path, alert: "Você não tem permissão para acessar essa lista."
  end
end
