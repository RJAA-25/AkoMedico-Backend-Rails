require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) { FactoryBot.build(:category) }

  it "validates presence of name" do
    category.name = nil
    expect(category).to_not be_valid
  end

  it "validates presence of folder id" do
    category.folder_id = nil
    expect(category).to_not be_valid
  end
end
