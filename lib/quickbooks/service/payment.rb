module Quickbooks
  module Service
    class Payment < BaseService
      include ServiceCrud

      private

      def default_model_query
        "SELECT * FROM PAYMENT"
      end

      def model
        Quickbooks::Model::Payment
      end

    end
  end
end