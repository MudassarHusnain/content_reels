require 'rails_helper'

RSpec.describe Project, type: :model do
  it "is valid with attributes" do
    project = Project.new(name: "example12",user_id: 1)
    expect(project).to be_valid
  end

  it "is not valid less than 8 character" do
      project = Project.new(name: "example",user_id:1)
      expect(project).not_to be_valid
  end
  it "is not valid without a name" do
      project = Project.new(name: nil,user_id: 1)
      expect(project).not_to be_valid
  end
  it "is not valid if user_id is not exixt" do
    project = Project.new(name: "mudasssarjutt")
    expect(project).not_to be_valid
  end
end
