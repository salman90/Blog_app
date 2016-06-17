require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "validations" do
    it "require a title" do
      p = Post.new
      result = p.valid?
      expect(p.errors).to have_key(:title)
    end
    it "require a body" do
      p = Post.new
      p.valid?
    expect(p.errors).to have_key(:body)
    end
    it "require a uniqe title" do
      Post.create(title: "abc", body: "salman")
      p = Post.new(title:"abc")
      p.valid?
      expect(p.errors).to have_key(:title)

    end
    it "require the minimum lenght of the title to be more than 7 characters" do
    p = Post.new(title:"hello world")
    p.valid?
    expect(p.errors).to have_key(:title)
    end

  end
describe ".body_snippet" do
  it "return 100 charcters with ... if the post's body is longer than 100 characters" do
    p = Post.create(title:"aeadawdwadwa", body: "0" * 150 )
    expect(p.body_snippet.length).to eq(103)
  end
end

end
