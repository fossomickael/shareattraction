require 'rails_helper'

RSpec.describe Attraction, type: :model do
  it "should have a name" do
    attraction = build(:attraction, name: nil)
    expect(attraction).to_not be_valid
  end
  it "should have a description" do
    attraction = build(:attraction, description: nil)
    expect(attraction).to_not be_valid
  end
end
