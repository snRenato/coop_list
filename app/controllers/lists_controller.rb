class ListsController < ApplicationController
    # generate the standard CRUD actions
    def index
        @lists = List.all
    end

    def new
        @list = List.new
    end

    def show
        @list = List.find(params[:id])
    end

    def create
        @list = List.new(list_params)
        if @list.save
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
        params.require(:list).permit(:title, :category )
    end
end
