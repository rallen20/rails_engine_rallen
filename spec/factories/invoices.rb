FactoryBot.define do
  factory :invoice do
    customer { association :customer }
    merchant { association :merchant }
    status { 1 }
  end
end
