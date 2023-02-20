class Api::V1::FactsController < ApplicationController
    before_action :find_fact,only: [:update,:destroy,:show]
    def index
        @facts = Fact.all
        render json:FactSerializer.new(@facts).serializable_hash.to_json
    end

    def create
        # byebug
        @fact = Fact.create!(fact_params)
        # @fact = Fact.new(fact: params[:fact],user_id: params[:user_id])
        if @fact.save
            render json:@fact
        else
            render error:{error:"Unable to create fact"}, status: 400
        end
    end

    def create_many
        # @facts = params[:facts]
        # # p @facts[0]
        # f = []
        # Fact.transaction do
        # @facts.each{|fact|
        #     @fact = Fact.new(fact: fact[:fact],user_id: params[:user_id])
        #     if @fact.save
        #         # render json:FactSerializer.new(@fact).serializable_hash.to_json
        #         # f << FactSerializer.new(@fact).serializable_hash.to_json
        #         f << @fact
                
        #     else
        #         # render error:{error:"Unable to create fact"}, status: 400
        #     end
        # }
        # end
        # render json:FactSerializer.new(f).serializable_hash[:data].map{|record| record[:attributes]}
            

        # p params[:facts]
        @user = User.find(params[:user_id])
        # puts "post_params #{many_facts_params.inspect}"
        # puts "post_params #{many_facts_params[:facts]}"
        Fact.transaction do
            @facts = @user.facts.create!(many_facts_params[:facts])
        end
        render json:@facts
        render json:FactSerializer.new(@facts).serializable_hash[:data].map{|record| record[:attributes]}
    end

    def show
        if @fact
            render json:FactSerializer.new(@fact).serializable_hash.to_json
        else
            render error:{error:"Unable to find fact"}, status: 400
        end
    end

    def update
        if @fact
            @fact.update(fact_params)
            render json:{message:"fact updated successfully"}, status: 200
        else
            render error:{error:"Unable to find fact"}, status: 400
        end
    end

    def destroy
        if @fact
            if @fact.destroy
                render json:{message:"User updated successfully"}, status: 200
            else
                render json:{message:"Unable to destroy user"}, status: 400
            end
        else
            render error:{error:"Unable to find user"}, status: 400
        end
    end


    private

    def fact_params
        p params
        params.require(:fact).permit(:fact,:user_id)
    end

    def many_facts_params
        p "8" * 20
        # p params.require(:facts)
        # p params
        # byebug
        # params.require(:facts).map{|f| f.permit(:fact)}
        # params.require(:facts).permit()
        # params.permit(facts: [:fact])
        params.require(:facts).permit(data: [])

        # byebug
    end

    def find_fact
        @fact = Fact.find(params[:id])
    end


end
