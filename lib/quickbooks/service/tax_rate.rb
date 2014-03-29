module Quickbooks
  module Service
    class TaxRate < BaseService
      include ServiceCrud

      def default_model_query
        "SELECT * FROM TaxRate"
      end

      def create(entity, options = {})
        raise "Not implemented for this Entity"
      end

      def update(entity, options = {})
        raise "Not implemented for this Entity"
      end

      def delete(entity)
        raise "Not implemented for this Entity"
      end

      def model
        Quickbooks::Model::TaxRate
      end
    end
  end
end
