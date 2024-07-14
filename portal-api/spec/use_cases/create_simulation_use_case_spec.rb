# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateSimulationUseCase do
  describe '.call!' do
    subject { described_class.call!(customer: customer, electricity_bill: electricity_bill) }

    let(:customer) { create(:customer) }
    let(:electricity_bill) { 100 }

    it 'creates a simulation' do
      expect { subject }.to change(Simulation, :count).by(1)
    end

    it 'returns the created simulation' do
      expect(subject).to be_a(Simulation)
      expect(subject.customer).to eq(customer)
      expect(subject.electricity_bill).to eq(electricity_bill)
      expect(subject.power).to eq(electricity_bill / 94.5)
    end

    context 'with customer is missing' do
      let(:customer) { nil }

      it 'raises an error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'with electricity_bill is missing' do
      let(:electricity_bill) { nil }

      it 'raises an error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when the customer exceeds the limit per day' do
      before do
        allow(customer.simulations).to receive(:today).and_return(double(count: 6))
      end

      it 'raises an error' do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
