module Quickbooks
  module Model
    class Payment < BaseModel
      REST_RESOURCE = 'payment'
      XML_COLLECTION_NODE = "Payment"
      XML_NODE = "Payment"

      xml_accessor :id, :from => 'Id', :as => Integer
      xml_accessor :sync_token, :from => 'SyncToken', :as => Integer
      xml_accessor :payment_ref, :from => 'PaymentRefNum'
      xml_accessor :customer_ref, :from => 'CustomerRef', :as => BaseReference
      xml_accessor :payment_method_ref, :from => 'PaymentMethodRef', :as => BaseReference
      xml_accessor :deposit_to_account_ref, :from => 'DepositToAccountRef', :as => BaseReference
      xml_accessor :txn_date, :from => 'TxnDate', :as => Date
      xml_accessor :active, :from => 'Active'
      xml_accessor :amount, :from => 'TotalAmt', :as => BigDecimal, :to_xml => Proc.new { |val| val.to_f }
      xml_accessor :line_items, :from => 'Line', :as => [PaymentLineItem]

      reference_setters :customer_ref,:payment_ref,:payment_method_ref

      #== Validations
      validates_length_of :line_items, :minimum => 1
      validate :existence_of_customer_ref
      validate :existence_of_amount

      def initialize
        ensure_line_items_initialization
        super
      end

      def link_to_invoice(invoice_id)
        self.line_items << Quickbooks::Model::PaymentLineItem.new.tap do |li|
          li.amount = self.amount
          li.linked_transactions = []
          li.linked_transactions << Quickbooks::Model::LinkedTransaction.new.tap do |t|
            t.txn_id = invoice_id
            t.txn_type = "Invoice"
          end
        end
      end

      private

      def ensure_line_items_initialization
        self.line_items ||= []
      end

      def existence_of_customer_ref
        if customer_ref.nil? || (customer_ref && customer_ref.value == 0)
          errors.add(:customer_ref, "CustomerRef is required and must be a non-zero value.")
        end
      end

      def existence_of_amount
        if amount.nil? || (amount < 0)
          errors.add(:amount, "Amount is required and must be a positive value.")
        end
      end

    end
  end
end
