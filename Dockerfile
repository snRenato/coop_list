# === Etapa 1: Build da aplicação ===
FROM ruby:3.4.7-alpine AS build

# Instala dependências do sistema necessárias para gems, Node, Yarn, Postgres
RUN apk add --no-cache \
    build-base \
    git \
    nodejs \
    yarn \
    postgresql-dev \
    bash \
    tzdata \
    imagemagick \
    libxml2-dev \
    libxslt-dev \
    yaml-dev \
    pkgconfig \
    curl

# Define diretório de trabalho
WORKDIR /app

# Copia Gemfile e Gemfile.lock para cache de gems
COPY Gemfile Gemfile.lock ./

# Instala gems
RUN bundle config set --local deployment 'true' \
    && bundle install --jobs 4 --retry 3

# Copia o restante do código
COPY . .

# Instala pacotes JS (Tailwind, Hotwire)
RUN yarn install --check-files

# Precompila assets para produção
RUN RAILS_ENV=production SECRET_KEY_BASE=1 ./bin/rails assets:precompile

# Limpa caches desnecessários
RUN rm -rf node_modules tmp/cache log/*

# === Etapa 2: Imagem final leve ===
FROM ruby:3.4.7-alpine

WORKDIR /app

# Copia gems e código da etapa build
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /app /app

# Variáveis de ambiente essenciais
ENV RAILS_ENV=production \
    RACK_ENV=production \
    PORT=3000 \
    BUNDLE_PATH=/usr/local/bundle \
    PATH="/usr/local/bundle/bin:${PATH}"

# Expondo a porta padrão
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
