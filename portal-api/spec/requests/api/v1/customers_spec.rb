# frozen_string_literal: true

require 'swagger_helper'

describe 'Customers API' do
  path '/api/v1/customer' do
    post 'Creates a customer' do
      tags 'Customers'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[name email password]
      }

      response '200', 'customer created' do
        schema(type: :object,
               properties: {
                 status: { type: :string },
                 data: {
                   type: :object,
                   properties: {
                     email: { type: :string },
                     provider: { type: :string },
                     uid: { type: :string },
                     id: { type: :integer },
                     allow_password_change: { type: :boolean },
                     name: { type: :string },
                     nickname: { type: :string, nullable: true },
                     image: { type: :string, nullable: true },
                     created_at: { type: :string },
                     updated_at: { type: :string }
                   }
                 }
               })

        let(:params) { { name: 'John', email: 'john@test.test', password: '123456' } }

        run_test!
      end

      response '422', 'invalid request' do
        context 'when name is missing' do
          let(:params) { { email: 'john@test.test', password: '123456' } }

          run_test!
        end

        context 'when email is missing' do
          let(:params) { { name: 'John', password: '123456' } }

          run_test!
        end

        context 'when password is missing' do
          let(:params) { { name: 'John', email: 'john@test.test' } }

          run_test!
        end

        context 'when email is already taken' do
          let!(:customer) { create(:customer) }

          let(:params) { { name: 'John', email: customer.email, password: '123456' } }

          run_test!
        end
      end
    end

    delete 'Deletes a Customer' do
      tags 'Customers'
      produces 'application/json'
      security [auth_token: []]

      let(:customer) { create(:customer) }
      let('Authorization') { customer.create_new_auth_token['Authorization'] }

      response '200', 'customer deleted' do
        run_test!
      end

      response '404', 'customer not found' do
        let('Authorization') { 'invalid' }

        run_test!
      end
    end
  end

  path '/api/v1/customer/sign_in' do
    post 'Sign in a customer' do
      tags 'Customers'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      response '200', 'customer signed in' do
        schema(type: :object,
               properties: {
                 data: {
                   type: :object,
                   properties: {
                     email: { type: :string },
                     provider: { type: :string },
                     uid: { type: :string },
                     id: { type: :integer },
                     allow_password_change: { type: :boolean },
                     name: { type: :string },
                     nickname: { type: :string, nullable: true },
                     image: { type: :string, nullable: true }
                   }
                 }
               })

        let(:customer) { create(:customer) }
        let(:params) { { email: customer.email, password: customer.password } }

        run_test!
      end

      response '401', 'invalid credentials' do
        schema(type: :object,
               properties: {
                 success: { type: :boolean },
                 errors: { type: :array, items: { type: :string } }
               })

        let(:customer) { create(:customer) }
        let(:params) { { email: customer.email, password: 'invalid' } }

        run_test!
      end
    end
  end

  path '/api/v1/customers/{id}' do
    customer_schema = {
      type: :object,
      properties: {
        id: { type: :integer },
        name: { type: :string },
        email: { type: :string },
        created_at: { type: :string },
        updated_at: { type: :string }
      }
    }

    get 'Retrieves a customer' do
      tags 'Customers'
      produces 'application/json'
      security [auth_token: []]

      parameter name: :id, in: :path, type: :integer

      let(:customer) { create(:customer) }
      let(:id) { customer.id }
      let('Authorization') { customer.create_new_auth_token['Authorization'] }

      response '200', 'customer found' do
        schema customer_schema

        run_test!
      end

      response '401', 'unauthorized' do
        let('Authorization') { 'invalid' }

        run_test!
      end
    end

    put 'Updates a customer' do
      tags 'Customers'
      consumes 'application/json'
      produces 'application/json'
      security [auth_token: []]

      parameter name: :id, in: :path, type: :integer
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string }
        }
      }

      let(:customer) { create(:customer) }
      let(:id) { customer.id }
      let('Authorization') { customer.create_new_auth_token['Authorization'] }
      let(:params) { { name: 'John upgraded', email: 'johnupgraded@test.test' } }

      response '200', 'customer updated' do
        schema customer_schema

        run_test! do |response|
          data = JSON.parse(response.body)['customer']

          expect(data['name']).to eq('John upgraded')
          expect(data['email']).to eq('johnupgraded@test.test')
        end
      end

      response '422', 'invalid request' do
        context 'when name is missing' do
          let(:params) { { name: '', email: customer.email } }

          run_test!
        end

        context 'when email is missing' do
          let(:params) { { name: customer.name, email: '' } }

          run_test!
        end

        context 'when email is invalid' do
          let(:params) { { name: customer.name, email: 'invalid' } }

          run_test!
        end

        context 'when email is already taken' do
          let(:persisted_customer) { create(:customer, email: 'test@test.test') }

          let(:params) { { name: customer.name, email: persisted_customer.email } }

          run_test!
        end
      end

      response '401', 'unauthorized' do
        let('Authorization') { 'invalid' }

        run_test!
      end
    end
  end
end
