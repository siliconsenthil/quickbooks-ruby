module Quickbooks
  module Model
    class SalesTaxRateList < BaseModel

      xml_accessor :tax_rate_detail, :from => 'TaxRateDetail', :as => [TaxRateDetail]

    end
  end
end
