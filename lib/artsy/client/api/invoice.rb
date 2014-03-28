module Artsy
  module Client
    module API
      module Invoice
        include Artsy::Client::API::Parse

        # Retrieves an invoice that is ready for payment.
        #
        # @param token [String]
        # @return [Artsy::Client::Domain::Invoice]
        def invoice_by_token(token)
          object_from_response(self, Artsy::Client::Domain::Invoice, :get, "/api/v1/invoice", token: token)
        end

        # Adds a payment to an invoice.
        #
        # @param id [String]
        # @param params [Hash]
        # @return [Artsy::Client::Domain::InvoicePayment]
        def create_invoice_payment(id, params = {})
          object_from_response(self, Artsy::Client::Domain::InvoicePayment, :post, "/api/v1/invoice/#{id}/payment", params)
        end

      end
    end
  end
end
