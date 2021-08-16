require 'rails_helper'

RSpec.describe "packages/index", type: :view do
  before(:each) do
    assign(:packages, [
      Package.create!(),
      Package.create!()
    ])
  end

  it "renders a list of packages" do
    render
  end
end
