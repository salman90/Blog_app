require 'rails_helper'

RSpec.describe Favourite, type: :model do
  describe "validates" do
    it "validates uniqueness between user_id and post_id" do
      should validate_uniqueness_of(:user_id).scoped_to(:post_id) 
    end
  end
end
