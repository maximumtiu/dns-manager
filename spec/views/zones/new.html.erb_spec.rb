require 'rails_helper'

RSpec.describe "zones/new", type: :view do
  before(:each) do
    assign(:zone, Zone.new(
      :zone => "MyString"
    ))
  end

  it "renders new zone form" do
    render

    assert_select "form[action=?][method=?]", zones_path, "post" do

      assert_select "input[name=?]", "zone[zone]"
    end
  end
end
