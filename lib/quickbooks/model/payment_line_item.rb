module Quickbooks
  module Model
    class PaymentLineItem < BaseModel
      xml_accessor :amount, :from => 'Amount', :as => BigDecimal, :to_xml => Proc.new { |val| val.to_f }
      xml_accessor :linked_transactions, :from => 'LinkedTxn', :as => [LinkedTransaction]
    end
  end
end