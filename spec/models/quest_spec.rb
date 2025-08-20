require 'rails_helper'

RSpec.describe Quest, type: :model do
  it "is valid with a name and status" do
    quest = build(:quest)
    expect(quest).to be_valid
  end

  it "is invalid without a name" do
    quest = build(:quest, name: nil)
    quest.valid?
    expect(quest.errors[:name]).to include("can't be blank")
  end

  it "is invalid with a name longer than 100 characters" do
    quest = build(:quest, name: "a" * 101)
    quest.valid?
    expect(quest.errors[:name]).to include("is too long (maximum is 100 characters)")
  end

  it "is invalid without a status" do
    quest = build(:quest, status: nil)
    quest.valid?
    expect(quest.errors[:status]).to include("is not included in the list")
  end
end
