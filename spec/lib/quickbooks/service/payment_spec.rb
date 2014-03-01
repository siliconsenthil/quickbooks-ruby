describe "Quickbooks::Service::Payment" do
  before(:all) do
    construct_service :payment
  end

  it "can query for payments" do
    xml = fixture("payments.xml")
    model = Quickbooks::Model::Payment

    stub_request(:get, @service.url_for_query, ["200", "OK"], xml)
    payments = @service.query
    payments.entries.count.should == 3

    first_payment = payments.entries.first
    expect(first_payment.id.to_i).to eq(5)
  end

  it "can fetch a payment by ID" do
    xml = fixture("fetch_payment_by_id.xml")
    model = Quickbooks::Model::Payment
    stub_request(:get, "#{@service.url_for_resource(model::REST_RESOURCE)}/5", ["200", "OK"], xml)
    payment = @service.fetch_by_id(5)
    expect(payment.id.to_i).to eq(5)
  end

  it "should not create the payment request without customer ref" do
    payment = Quickbooks::Model::Payment.new
    payment.amount = BigDecimal.new(20,2)
    lambda do
      @service.create(payment)
    end.should raise_error(InvalidModelException)
  end

  it "should not create the payment request without total amount" do
    payment = Quickbooks::Model::Payment.new
    payment.customer_id = 1
    lambda do
      @service.create(payment)
    end.should raise_error(InvalidModelException)
  end


  it "can create an payment" do
    xml = fixture("fetch_payment_by_id.xml")
    model = Quickbooks::Model::Payment

    stub_request(:post, @service.url_for_resource(model::REST_RESOURCE), ["200", "OK"], xml)

    payment = Quickbooks::Model::Payment.new
    payment.customer_id = 1
    payment.amount = 30
    payment.line_items <<  Quickbooks::Model::PaymentLineItem.new.tap do |li|
      li.amount = BigDecimal.new(30,2)
      li.linked_transactions = []
      li.linked_transactions << Quickbooks::Model::LinkedTransaction.new.tap do |t|
        t.txn_id = 2
        t.txn_type = "Payment"
      end
    end

    created_payment = @service.create(payment)
    expect(created_payment.id).to eq(5)
  end
end
