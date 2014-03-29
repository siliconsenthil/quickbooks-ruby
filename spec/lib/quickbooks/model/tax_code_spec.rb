require 'nokogiri'

describe "Quickbooks::Model::TaxCode" do
  it "parse from XML" do
    xml = fixture("tax_code.xml")
    tax_code = Quickbooks::Model::TaxCode.from_xml(xml)
    expect(tax_code.id).to eql(2.to_s)
    expect(tax_code.sync_token).to eql(0)
    expect(tax_code.name).to eql("Federal Tax")
    expect(tax_code.taxable?).to eql(true)
    expect(tax_code.tax_group?).to eql(true)
    expect(tax_code.description).to eql("Federal Tax")
    expect(tax_code.sales_tax_rate_list).to be_instance_of(Quickbooks::Model::SalesTaxRateList)
    expect(tax_code.sales_tax_rate_list).to have(1).tax_rate_detail
    tax_rate = tax_code.sales_tax_rate_list.tax_rate_detail[0]
    expect(tax_rate.tax_rate_ref.to_i).to eq(1)
  end

  it "should check empty model" do
    tax_code = Quickbooks::Model::TaxCode.new
    expect(tax_code.id).to be_nil
    expect(tax_code.taxable?).to eql(false)
    expect(tax_code.tax_group?).to eql(false)
    expect(tax_code.tax_rates).to eql([])
  end
end
