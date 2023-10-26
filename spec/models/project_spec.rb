require 'rails_helper'

RSpec.describe Project, type: :model do
  it "is valid with attributes" do
    project = Project.new(name: "example12")
    expect(project).to be_valid
  end

  it "is not valid less than 8 character" do
      project = Project.new(name: "example")
      expect(project).not_to be_valid
  end
  it "is not valid without a name" do
      project = Project.new(name: nil)
      expect(project).not_to be_valid
  end
end
