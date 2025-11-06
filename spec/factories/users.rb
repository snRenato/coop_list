FactoryBot.define do
  factory :user do
    name { "Usuário Teste" }
    sequence(:email) { |n| "user#{n}@teste.com" }
    password { "password123" }
    password_confirmation { "password123" }
  end
end
