FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    unit_price { 1 }
    merchant { association :merchant }
  end
end
