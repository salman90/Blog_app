require 'rails_helper'

RSpec.describe Favourite, type: :model do
  describe "validates" do
    it "validates uniqueness between user_id and post_id" do
      f = Favourite.new FactoryGirl.attributes_for(:favourite).merge({user_id: nil})
      expect(f).to be_invalid
       should validate_uniqueness_of(:user_id).scoped_to(:user_id, :post_id)
      #  should validate_uniqueness_of(:user_id)
    end
    it "it requires a user_id " do
      f = Favourite.new FactoryGirl.attributes_for(:favourite).merge({user_id: nil})
      expect(f).to be_invalid
    end
    it "it requires a post_id " do
      f = Favourite.new FactoryGirl.attributes_for(:favourite).merge({post_id: nil})
      expect(f).to be_invalid
    end
  end
end
