# spec/factories/members.rb
FactoryBot.define do
  factory :member do
    user
    list

    # 👇 Adicione esta linha
    # Use o valor padrão que faz sentido para sua aplicação
    # (ex: "active", "pending", 0, true, etc.)
    status { "accepted" }
  end
end
