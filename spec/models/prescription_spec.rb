require 'rails_helper'

RSpec.describe Prescription, type: :model do
  let(:prescribe) { FactoryBot.build(:prescription, :for_consult) }

  it "validates presence of image url" do
    prescribe.image_url = nil
    expect(prescribe).to_not be_valid
  end
end
