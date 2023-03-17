require 'rails_helper'

RSpec.describe Result, type: :model do
  let(:result) { FactoryBot.build(:result, :for_consult) }

  it "validates presence of image url" do
    result.image_url = nil
    expect(result).to_not be_valid
  end
end
