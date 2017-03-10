require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
     it "require a first_name" do
       u = User.new FactoryGirl.attributes_for(:user).merge({first_name: nil})
       expect(u).to be_invalid
     end
     it "requires presence of last_name" do
       u = User.new FactoryGirl.attributes_for(:user).merge({last_name: nil})
       expect(u).to be_invalid
     end
     it "requires presence of email" do
       u = User.new FactoryGirl.attributes_for(:user).merge({email: nil})
       expect(u).to be_invalid
     end
     it "requires unique email" do
       u = FactoryGirl.create(:user)
       u2 = User.new FactoryGirl.attributes_for(:user).merge({email: u.email})
       expect(u2).to be_invalid
    end
  end
  describe ".full_name" do
    it "returns the first name and the last name concatenated" do
      u = User.new({first_name: "salman", last_name: "salem"})
      expect(u.full_name).to eq("Salman Salem")
    end
  end
end
