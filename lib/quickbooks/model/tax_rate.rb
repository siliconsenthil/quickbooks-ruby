module Quickbooks
  module Model
    class TaxRate < BaseModel
      XML_COLLECTION_NODE = "TaxRate"
      XML_NODE = "TaxRate"
      REST_RESOURCE = 'taxrate'

      xml_name XML_NODE
      xml_accessor :id, :from => 'Id', :as => Integer
      xml_accessor :sync_token, :from => 'SyncToken', :as => Integer
      xml_accessor :meta_data, :from => 'MetaData', :as => MetaData
      xml_accessor :name, :from => 'Name'
      xml_accessor :description, :from => 'Description'
      xml_accessor :special_tax_type, :from => 'SpecialTaxType'
      xml_accessor :active, :from => 'Active'
      xml_accessor :rate_value, :from => 'RateValue', :as => BigDecimal, :to_xml => Proc.new { |val|val &&  val.to_f }
      xml_accessor :agency_ref, :from => 'AgencyRef', :as => BaseReference

      reference_setters :agency_ref

      def active?
        "true" == active
      end
    end
  end
end
