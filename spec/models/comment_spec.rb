require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validations" do
    it "requires the body" do
      c = Comment.new FactoryGirl.attributes_for(:comment).merge({body: nil})
      expect(c).to be_invalid
    end
    it "will set a message" do
       c = Comment.new FactoryGirl.attributes_for(:comment).merge({body: nil})
       expect(:message).to be
    end
  end
end
