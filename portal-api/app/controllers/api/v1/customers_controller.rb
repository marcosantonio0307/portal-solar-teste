# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController
      before_action :authenticate_customer!
      before_action :customer, only: %i[show update]

      def show; end

      def update
        @customer.update!(permitted_params)
      end

      private

      def customer
        @customer ||= Customer.find(params[:id])
      end

      def permitted_params
        params.permit(:name, :email)
      end
    end
  end
end
