require 'rails_helper'

RSpec.describe Abstract, type: :model do
  let(:abstract) { FactoryBot.build(:abstract) }

  it "validates presence of file_id" do
    abstract.file_id = nil
    expect(abstract).to_not be_valid
  end

  it "validates presence of image link" do
    abstract.image_link = nil
    expect(abstract).to_not be_valid
  end

  it "validates presence of download link" do
    abstract.download_link = nil
    expect(abstract).to_not be_valid
  end

end
