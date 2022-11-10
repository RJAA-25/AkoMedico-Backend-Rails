require 'rails_helper'

RSpec.describe Result, type: :model do
  let(:result) { FactoryBot.build(:result, :for_consult) }

  it "validates presence of file_id" do
    result.file_id = nil
    expect(result).to_not be_valid
  end

  it "validates presence of image link" do
    result.image_link = nil
    expect(result).to_not be_valid
  end

  it "validates presence of download link" do
    result.download_link = nil
    expect(result).to_not be_valid
  end
end
