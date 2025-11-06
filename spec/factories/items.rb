FactoryBot.define do
  factory :item do
    name { "Item Teste" }
    status { false }
    association :list
  end
end
