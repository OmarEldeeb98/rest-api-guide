class Api::V1::CategoriesController < ApplicationController
    def index
        @categories = Category.paginate(page: (page_params[:page]? page_params[:page]: @page),per_page: (page_params[:per_page]? page_params[:per_page]: @per_page))
        # render json: @categories
        # render json:CategorySerializer.new(@categories).serializable_hash[:data].map{|record| record[:attributes]}
        render json:CategorySerializer.new(@categories).serializable_hash.to_json
    end

    def create
        @category= Category.new(category_params)
        if @category.save
            render json:CategorySerializer.new(@category).serializable_hash.to_json
        end
    end






    private 
    def category_params
        params.require(:category).permit(:name)
    end
end
