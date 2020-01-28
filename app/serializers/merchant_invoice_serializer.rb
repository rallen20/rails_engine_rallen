class MerchantInvoiceSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :customer_id, :merchant_id, :status
end
