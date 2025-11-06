class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_list, only: %i[show update destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  def index
    # Usa o escopo do Pundit em vez de filtragem manual
    @lists = policy_scope(List)
  end

  def show
    authorize @list
  end

  def new
    @list = List.new
    authorize @list
  end

  def create
    @list = List.new(list_params)
    @list.owner = current_user
    authorize @list

    respond_to do |format|
      if @list.save
        format.html { redirect_to lists_path, notice: "Lista criada com sucesso!" }
        format.json { render json: @list, status: :created }
        redirect_to @list
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @list

    if @list.update(list_params)
      render json: @list, status: :ok
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  def destroy
    authorize @list
    @list.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to lists_path, notice: "Lista excluída com sucesso." }
    end
  end

  private

  def set_list
    @list = List.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:title)
  end
end
