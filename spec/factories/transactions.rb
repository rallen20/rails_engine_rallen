FactoryBot.define do
  factory :transaction do
    invoice { association :invoice }
    credit_card_number { "MyString" }
    credit_card_expiration_date { "MyString" }
    result { 1 }
  end
end
