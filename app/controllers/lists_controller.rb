class ListsController < ApplicationController
    before_action :authenticate_user!

    def index
        @lists = List.select do |m|
            m.members.exists?(user_id: current_user.id) || m.owner_id == current_user.id
        end
    end

    def new
        @list = List.new
    end

    def show
        @list = List.find(params[:id])
        authorize @list, :show?
    end

    def create
        @list = List.new(list_params)
        @list.owner_id = current_user.id
        if @list.save!
            render json: @list, status: :created
        else
            render json: @list.errors, status: :unprocessable_entity
        end
    end

    def update
        @list = List.find(params[:id])
        if @list.update(list_params)
            render json: @list
        else
            render json: @list.errors, status: :unprocessable_entity
        end
    end

   def destroy
        @list = List.find(params[:id])
        authorize @list if defined?(Pundit)
        @list.destroy
        respond_to do |format|
            format.turbo_stream
            format.html { redirect_to lists_path, notice: "Lista excluída com sucesso." }
        end
    end

    private

    def list_params
        params.require(:list).permit(:title, :category, :owner_id)
    end

    def authorize_user!
        unless @list.owner == current_user || @list.members.exists?(user: current_user)
            redirect_to lists_path, alert: "Você não tem permissão para acessar esta lista."
        end
    end
end
