module Quickbooks
  module Model
    class TaxCode < BaseModel
      XML_COLLECTION_NODE = "TaxCode"
      XML_NODE = "TaxCode"
      REST_RESOURCE = 'taxcode'

      xml_name XML_NODE
      xml_accessor :id, :from => 'Id'
      xml_accessor :sync_token, :from => 'SyncToken', :as => Integer
      xml_accessor :meta_data, :from => 'MetaData', :as => MetaData
      xml_accessor :name, :from => 'Name'
      xml_accessor :description, :from => 'Description'
      xml_accessor :taxable, :from => 'Taxable'
      xml_accessor :tax_group, :from => 'TaxGroup'
      xml_accessor :sales_tax_rate_list, :from => 'SalesTaxRateList', :as => SalesTaxRateList

      def taxable?
        taxable.to_s == 'true'
      end

      def tax_group?
        tax_group.to_s == 'true'
      end

      def tax_rates
        sales_tax_rate_list.nil? ? [] : sales_tax_rate_list.tax_rate_detail
      end
    end
  end
end
