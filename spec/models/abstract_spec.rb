require 'rails_helper'

RSpec.describe Abstract, type: :model do
  let(:abstract) { FactoryBot.build(:abstract) }

  it "validates presence of image url" do
    abstract.image_url = nil
    expect(abstract).to_not be_valid
  end
end
