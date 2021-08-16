require 'rails_helper'

RSpec.describe "packages/show", type: :view do
  before(:each) do
    @package = assign(:package, Package.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
