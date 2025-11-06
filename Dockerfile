# =============================
# Stage 1: Build
# =============================
ARG RUBY_VERSION=3.4.7
FROM ruby:$RUBY_VERSION-slim AS builder

# --- Build-time args ---
ARG RAILS_MASTER_KEY

# --- Environment ---
ENV DEBIAN_FRONTEND=noninteractive \
    BUNDLE_PATH=/usr/local/bundle \
    LANG=C.UTF-8 \
    PATH="/usr/local/bundle/bin:${PATH}"

# --- Install dependencies for building gems and assets ---
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
        build-essential \
        git \
        libpq-dev \
        nodejs \
        npm \
        libyaml-dev \
        pkg-config \
        curl \
        gnupg \
        ca-certificates && \
    npm install -g yarn && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

# --- Working directory ---
WORKDIR /coop_list

# --- Install gems ---
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --without development test

# --- Copy source code ---
COPY . .

# --- Install JS dependencies ---
RUN yarn install --check-files

# --- Precompile assets (DB dummy para não quebrar) ---
ENV POSTGRES_HOST=dummy \
    POSTGRES_USER=dummy \
    POSTGRES_PASSWORD=dummy \
    POSTGRES_DB=dummy \
    SECRET_KEY_BASE=1 \
    RAILS_ENV=production
RUN bundle exec rails assets:precompile

# =============================
# Stage 2: Production image
# =============================
FROM ruby:$RUBY_VERSION-slim AS production

# --- Environment ---
ENV RAILS_ENV=production \
    BUNDLE_PATH=/usr/local/bundle \
    LANG=C.UTF-8 \
    PATH="/usr/local/bundle/bin:${PATH}"

WORKDIR /coop_list

# --- Copy gems and assets from builder ---
COPY --from=builder /usr/local/bundle /usr/local/bundle
COPY --from=builder /coop_list /coop_list

# --- Install runtime dependencies only ---
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y libpq-dev nodejs npm && \
    npm install -g yarn && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives

# --- Expose Rails port ---
EXPOSE 3000

# --- Start server ---
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
