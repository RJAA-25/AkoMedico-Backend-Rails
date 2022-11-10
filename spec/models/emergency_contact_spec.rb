require 'rails_helper'

RSpec.describe EmergencyContact, type: :model do
  let(:emergency_contact) { FactoryBot.build(:emergency_contact) }

  it "validates presence of full name" do
    emergency_contact.full_name = nil
    expect(emergency_contact).to_not be_valid
  end

  it "validates presence of relationship" do
    emergency_contact.relationship = nil
    expect(emergency_contact).to_not be_valid
  end

  it "validates presence of contact_number" do
    emergency_contact.contact_number = nil
    expect(emergency_contact).to_not be_valid
  end
end
