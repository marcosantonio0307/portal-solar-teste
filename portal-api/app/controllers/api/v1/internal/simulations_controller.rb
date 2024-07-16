# frozen_string_literal: true

module Api
  module V1
    module Internal
      class SimulationsController < ApplicationController
        before_action :authenticate_internal_key, only: %i[index]

        def index
          @simulations = Simulation.all
                                   .order(created_at: :desc)
                                   .paginate(page: params[:page], per_page: per_page)
        end

        private

        def per_page
          params[:per_page] || 10
        end
      end
    end
  end
end
