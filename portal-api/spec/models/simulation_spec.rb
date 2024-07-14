# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Simulation do
  it { is_expected.to belong_to(:customer) }
  it { is_expected.to validate_presence_of(:electricity_bill) }
end
