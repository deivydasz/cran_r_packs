require 'rails_helper'

RSpec.describe "packages/edit", type: :view do
  before(:each) do
    @package = assign(:package, Package.create!())
  end

  it "renders the edit package form" do
    render

    assert_select "form[action=?][method=?]", package_path(@package), "post" do
    end
  end
end
