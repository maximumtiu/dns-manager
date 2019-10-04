require 'rails_helper'

RSpec.describe "zones/show", type: :view do
  before(:each) do
    @zone = assign(:zone, Zone.create!(
      :zone => "Zone",
      :dns_servers => ["MyText"]
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Zone/)
    expect(rendered).to match(/MyText/)
  end
end
