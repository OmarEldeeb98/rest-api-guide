require 'swagger_helper'

RSpec.describe 'user api' do
    path'/api/v1/users' do
        
        post 'create a user' do
            tags 'Users'
            consumes 'application/json'
            parameter name: :user, in: :body,schema:{
                type: :object,
                properties: {
                    username:   {type: :string},
                    password:   {type: :string}
                },
                required: ['username', 'password']
            }

            response '201', 'user created' do
                let(:user) { { name: 'Dodo', status: 'available' } }
                run_test!
            end
            response '422', 'invalid request' do
                let(:user) { { name: 'foo' } }
                run_test!
            end

        end

        get 'show a user' do
            tags 'Users'
            consumes 'application/json'
            parameter name: :id,in: :body,schema:{
                type: :object,
                properties: {
                    id: {type: :integer}
                },
                required: ['id']
            }
            response '201', 'user found' do
                let(:id) { { id: 1 } }
                run_test!
            end
            response '422', 'not valid request' do
                let(:id) { {  } }
                run_test!
            end
        end


    end
end
