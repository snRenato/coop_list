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
        @list.destroy
        head :no_content
    end

    private

    def list_params
        params.require(:list).permit(:title, :category, :owner_id)
    end
end
