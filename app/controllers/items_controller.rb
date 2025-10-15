class ItemsController < ApplicationController
    # add the list relationship
    before_action :set_list

  def new
    @item = @list.items.new
  end

  def create
    @item = @list.items.new(item_params)
    if @item.save
      redirect_to list_path(@list), notice: "Item criado!"
    else
      render :new
    end
  end

  def show
    @item = @list.items.find(params[:id])
  end

  def edit
    @item = @list.items.find(params[:id])
  end
  
  def update
    @item = @list.items.find(params[:id])
    if @item.update(item_params)
      redirect_to list_path(@list), notice: "Item atualizado!"
    else
      render :edit
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def item_params
    params.require(:item).permit(:name, :status)
  end
end
