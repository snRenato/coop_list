class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list
  before_action :set_item, only: [ :update ]

  def new
    @item = Item.new
  end

  def create
    authorize_manage_items!
    @item = @list.items.build(item_params)
    if @item.save
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("items_list", partial: "items/items", locals: { items: @list.items }),
          turbo_stream.replace("pending_count", partial: "lists/pending_count", locals: { list: @list })
        ]
      end
      format.html { redirect_to @list, notice: "Item adicionado!" }
    end
    else
    redirect_to @list, alert: @item.errors.full_messages.to_sentence
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
    member = @list.members.find_by(user: current_user)
  end
end
