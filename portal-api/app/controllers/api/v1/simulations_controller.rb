# frozen_string_literal: true

module Api
  module V1
    class SimulationsController < ApplicationController
      before_action :authenticate_customer!, only: %i[index create show download]
      before_action :customer, only: %i[index create show download]
      before_action :simulation, only: %i[show download]

      def index
        @simulations = @customer.simulations
                                .order(created_at: :desc)
                                .paginate(page: params[:page], per_page: per_page)
      end

      def create
        @simulation = CreateSimulationUseCase.call!(
          customer: @customer, electricity_bill: permitted_params[:electricity_bill]
        )

        SelectBestPowerGeneratorsUseCase.call(simulation: @simulation)
      end

      def show; end

      def download
        pdf_html = render_to_string(template: 'api/v1/simulations/download.pdf.erb')

        pdf_file = WickedPdf.new.pdf_from_string(pdf_html)
        temp_pdf = Tempfile.new(['simulation_', '.pdf'], encoding: 'ascii-8bit')
        temp_pdf.binmode
        temp_pdf.write(pdf_file)
        temp_pdf.close

        send_file(
          temp_pdf.path,
          filename: "simulation_#{@simulation.id}.pdf",
          type: 'application/pdf',
          disposition: 'attachment'
        )
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

      def simulation
        @simulation ||= @customer.simulations.find(params[:id])
      end
    end
  end
end
