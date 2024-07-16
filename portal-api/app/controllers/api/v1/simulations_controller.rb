# frozen_string_literal: true

module Api
  module V1
    class SimulationsController < ApplicationController
      before_action :authenticate_customer!, only: %i[index create show]
      before_action :customer, only: %i[index create show]

      def index
        @simulations = @customer.simulations
                                .order(created_at: :desc)
                                .paginate(page: params[:page], per_page: per_page)
      end

      def create
        @simulation = CreateSimulationUseCase.call!(
          customer: @customer, electricity_bill: permitted_params[:electricity_bill]
        )
      end

      def show
        @simulation = @customer.simulations.find(params[:id])
      end

      private

      def permitted_params
        params.permit(:electricity_bill)
      end

      def per_page
        params[:per_page] || 10
      end

      def customer
        @customer ||= current_customer
      end
    end
  end
end
