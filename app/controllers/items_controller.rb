class ItemsController < ApplicationController
    # add the list relationship
    before_action :set_list
    before_action :set_item, only: [ :update ]

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
    @item.update(item_params)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @list }
    end
  end

  def toggle
    @item = Item.find(params[:id])
    @item.update(status: !@item.status)

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to @item.list } # fallback
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
end
