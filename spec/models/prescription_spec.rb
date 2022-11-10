require 'rails_helper'

RSpec.describe Prescription, type: :model do
  let(:prescribe) { FactoryBot.build(:prescription, :for_consult) }

  it "validates presence of file_id" do
    prescribe.file_id = nil
    expect(prescribe).to_not be_valid
  end

  it "validates presence of image link" do
    prescribe.image_link = nil
    expect(prescribe).to_not be_valid
  end

  it "validates presence of download link" do
    prescribe.download_link = nil
    expect(prescribe).to_not be_valid
  end
end
