require 'rails_helper'

RSpec.describe "zones/index", type: :view do
  before(:each) do
    assign(:zones, [
      Zone.create!(
        :zone => "Zone",
        :dns_servers => "MyText"
      ),
      Zone.create!(
        :zone => "Zone",
        :dns_servers => "MyText"
      )
    ])
  end

  it "renders a list of zones" do
    render
    assert_select "tr>td", :text => "Zone".to_s, :count => 2
  end
end
