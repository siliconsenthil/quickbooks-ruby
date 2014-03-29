describe "Quickbooks::Service::TaxCode" do
  before(:all) do
    construct_service :tax_code
  end

  it "can query for tax codes" do
    xml = fixture("tax_codes.xml")
    stub_request(:get, @service.url_for_query, ["200", "OK"], xml)
    tax_codes = @service.query
    tax_codes.entries.count.should == 4

    tax_codes.entries.first.id.should == 'TAX'
    tax_code = tax_codes.entries.last
    tax_code.tax_rates.size.should == 1
    tax_code.tax_rates.first.tax_rate_ref.to_i.should == 1
  end

end
