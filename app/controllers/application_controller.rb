class ApplicationController < ActionController::API
    include ApiException::Handler
    include JsonWebToken

    before_action :authenticate_request
    class_attribute :page,:per_page
    def initialize
        @page = 1
        @per_page = 3
    end



    private
    def authenticate_request
        header = request.headers["Authorization"]
        header = header.split(" ").last if header 
        decoded = jwt_decode(header)
        @user = User.find(decoded[:user_id])
    end

    def page_params
        # p "================================="
        # p params
        params.permit(:page,:per_page)
    end
end
