# config/initializers/locale.rb
Rails.application.config.i18n.available_locales = [ :'pt-BR', :en ]
Rails.application.config.i18n.default_locale = :'pt-BR'
Rails.application.config.i18n.fallbacks = [ :en ]

# Garante que todos os arquivos .yml da pasta locales sejam carregados
I18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.yml")]

# (Opcional, mas corrige bug do Devise no Rails 8)
if Gem.loaded_specs["devise-i18n"]
  I18n.load_path += Dir[Gem.loaded_specs["devise-i18n"].full_gem_path + "/rails/locales/*.yml"]
end
