# frozen_string_literal: true

module Api
  module V1
    class SimulationsController < ApplicationController
      before_action :authenticate_customer!, only: %i[create]

      def create
        @simulation = CreateSimulationUseCase.call!(
          customer: current_customer, electricity_bill: permitted_params[:electricity_bill]
        )
      end

      private

      def permitted_params
        params.permit(:electricity_bill)
      end
    end
  end
end
