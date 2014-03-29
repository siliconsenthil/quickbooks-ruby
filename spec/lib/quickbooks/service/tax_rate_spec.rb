describe "Quickbooks::Service::TaxRate" do
  before(:all) do
    construct_service :tax_rate
  end

  it "can query for tax rates" do
    xml = fixture("tax_rates.xml")
    stub_request(:get, @service.url_for_query, ["200", "OK"], xml)
    tax_rates = @service.query
    tax_rates.entries.count.should == 9

    tax_rate = tax_rates.entries.first
    tax_rate.id.should == 4
    tax_rate.name.should == "blah1"
    tax_rate.description.should == "Sales Tax"
    tax_rate.active?.should == true
    tax_rate.rate_value.should == 10.0
    tax_rate.agency_ref.to_i.should == 2
  end

  it "raise exception for unsupported methods" do
    expect { @service.delete(Quickbooks::Model::TaxRate.new) }.to raise_error
    expect { @service.create(Quickbooks::Model::TaxRate.new) }.to raise_error
    expect { @service.update(Quickbooks::Model::TaxRate.new) }.to raise_error
  end

end
