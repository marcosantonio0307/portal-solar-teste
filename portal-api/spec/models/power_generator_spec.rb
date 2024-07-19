# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PowerGenerator, type: :model do
  it { is_expected.to validate_presence_of(:uuid) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:panels) }
  it { is_expected.to validate_presence_of(:power) }
  it { is_expected.to validate_presence_of(:image_url) }
end
