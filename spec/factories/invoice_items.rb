FactoryBot.define do
  factory :invoice_item do
    item { association :item}
    invoice { association :invoice }
    quantity { 1 }
    unit_price { 1 }
  end
end
