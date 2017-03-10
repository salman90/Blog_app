require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "validations" do
    it "require a title" do
      p = Post.new FactoryGirl.attributes_for(:post).merge({title: nil})
      expect(p).to be_invalid
    end
    it "require a body" do
      p = Post.new FactoryGirl.attributes_for(:post).merge({body: nil})
      expect(p).to be_invalid
    end
    it "require a uniqe title" do
      p = FactoryGirl.create(:post)
      p1 = Post.new FactoryGirl.attributes_for(:post).merge({title: p.title})
      expect(p1).to be_invalid
    end
  end
describe ".body_snippet" do
  it "return 100 charcters with ... if the post's body is longer than 100 characters" do
    p = Post.create(title:"aeadawdwadwa", body: "0" * 150 )
    expect(p.body_snippet.length).to eq(103)
  end
end

end
