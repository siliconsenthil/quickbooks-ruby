require 'nokogiri'

describe "Quickbooks::Model::TaxRate" do

  it "parse from XML" do
    xml = fixture("tax_rate.xml")
    tax_rate = Quickbooks::Model::TaxRate.from_xml(xml)
    expect(tax_rate.id).to eql(1)
    expect(tax_rate.name).to eql("Federal Tax")
    expect(tax_rate.rate_value).to eql(10.0)
  end

  it "should check active method" do
    tax_rate = Quickbooks::Model::TaxRate.new
    tax_rate.active = "Asd"
    expect(tax_rate.active?).to be_false
    tax_rate.active = "true"
    expect(tax_rate.active?).to be_true
  end
end
