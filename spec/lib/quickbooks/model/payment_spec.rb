describe "Quickbooks::Model::Payment" do
  it "parse from XML and check if payment object is correct or not" do
    xml = fixture("payment.xml")
    payment = Quickbooks::Model::Payment.from_xml(xml)
    payment.id.to_i.should == 4
    payment.amount.should == 40.0
    payment.txn_date.to_date.should == Date.civil(2014,2,27)
    payment.customer_ref.to_i.should == 1
    payment.line_items.should_not be_nil
    payment.line_items.size.should == 1
    line_item = payment.line_items[0]
    line_item.should be_an_instance_of Quickbooks::Model::PaymentLineItem
    line_item.amount.should == 40.0
    line_item.linked_transactions.should_not be_nil
    line_item.linked_transactions.size.should == 1
    transaction = line_item.linked_transactions[0]
    transaction.should be_an_instance_of Quickbooks::Model::LinkedTransaction
    transaction.txn_id.to_i.should == 2
    transaction.txn_type.should == "Invoice"
  end

  it "should check if conversion to xml is ok or not" do
    payment = Quickbooks::Model::Payment.new  
    payment.amount = BigDecimal.new(30,2)
    payment.txn_date = Date.today
    payment.line_items = []
    payment.line_items << Quickbooks::Model::PaymentLineItem.new.tap do |li|
      li.amount = BigDecimal.new(30,2)
      li.linked_transactions = []
      li.linked_transactions << Quickbooks::Model::LinkedTransaction.new.tap do |t|
        t.txn_id = 2
        t.txn_type = "Invoice"
      end
    end

    payment1 = Quickbooks::Model::Payment.from_xml(payment.to_xml.to_s)
    payment1 == payment
  end
end
