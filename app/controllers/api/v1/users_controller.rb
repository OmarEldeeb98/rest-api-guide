class Api::V1::UsersController < ApplicationController
    # before_action :set_locale
    before_action :find_user, only: [:show,:destroy]
    # validates_associated :facts
    skip_before_action :authenticate_request, only: [:create]
    
    def index
        p "=================="
        p http_accept_language
        byebug
        # @users = User.paginate(page_params)
        # p per_page
        @users = User.paginate(page: (page_params[:page]? page_params[:page]: @page),per_page: (page_params[:per_page]? page_params[:per_page]: @per_page))
        render json:@users
    end

    def create
        @user = User.new(user_params)
        p "=================="
        p @user.categories
        byebug
        # @user = User.new(username:params[:username],password:params[:password])
        if @user.save
            render json:@user
        else
            render error:{error:"Unable to create user"}, status: 400
        end
    end

    def show
        if @user
            p "======================"
            p @user.categories
            render json:UserSerializer.new(@user).serializable_hash.to_json
        else
            render error:{error:"Unable to find user"}, status: 400
        end
    end

    def update
        if @user
            @user.update(user_params)
            render json:{message:"User updated successfully"}, status: 200
        else
            render error:{error:"Unable to find user"}, status: 400
        end
    end

    def destroy
        if @user
            if @user.destroy
                render json:{message:"User updated successfully"}, status: 200
            else
                render json:{message:"Unable to destroy user"}, status: 400
            end
        else
            render error:{error:"Unable to find user"}, status: 400
        end
    end




    private
    
    def find_user
        @user = User.find(params[:id])
        # rescue ActiveRecord::RecordNotFound
        #     raise ApiException::RecordNotFound
    end

    def user_params
        # p "================================="
        # p params
        # params.permit(:page,:per_page)
        params.require(:user).permit(:username,:password,category_ids: [])
        
    end

    def set_locale
        I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    end

    

end
