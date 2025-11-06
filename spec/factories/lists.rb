FactoryBot.define do
  factory :list do
    title { "Lista de Teste" }
    association :owner, factory: :user
  end
end
