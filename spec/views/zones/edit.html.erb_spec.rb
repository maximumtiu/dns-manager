require 'rails_helper'

RSpec.describe "zones/edit", type: :view do
  before(:each) do
    @zone = assign(:zone, Zone.create!(
      :zone => "MyString"
    ))
  end

  it "renders the edit zone form" do
    render

    assert_select "form[action=?][method=?]", zone_path(@zone), "post" do

      assert_select "input[name=?]", "zone[zone]"
    end
  end
end
