class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list
  before_action :set_item, only: [ :update ]
  before_action :authorize_manage_items!, only: [ :new, :create, :update, :toggle ]

  def new
    @item = Item.new
  end

def create
  @item = @list.items.build(item_params)

  if @item.save
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.append("items_list", partial: "items/item", locals: { item: @item }),
          turbo_stream.replace("pending_count", partial: "lists/pending_count", locals: { list: @list }),
          turbo_stream.replace("new_item", partial: "items/form", locals: { list: @list, item: Item.new }) # limpa o form 👈
        ]
      end
      format.html { redirect_to @list, notice: "Item adicionado!" }
    end
  else
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "new_item",
          partial: "items/form",
          locals: { list: @list, item: @item }
        ), status: :unprocessable_entity
      end
      format.html { redirect_to @list, alert: @item.errors.full_messages.to_sentence }
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
  return if @list.owner == current_user

  member = @list.members.find_by(user: current_user)
  return if member&.accepted?

  respond_to do |format|
    format.html { redirect_to root_path, alert: "Você não tem permissão para acessar essa lista." }
    format.turbo_stream { head :forbidden }
  end
end
end
