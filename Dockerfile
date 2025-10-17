# Use a specific version of the official Ruby image for reproducibility
ARG RUBY_VERSION=3.4.7
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

# Declares build-time arguments passed from docker-compose.yml
ARG POSTGRES_HOST
ARG POSTGRES_USER
ARG POSTGRES_PASSWORD
ARG POSTGRES_DB
ARG RAILS_MASTER_KEY

# Prevents interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Set environment variables for Bundler.
# This ensures gems and their executables are installed in a standard location
# that is already part of the image's PATH, which solves the error.
ENV RAILS_ENV=development \
    BUNDLE_PATH=/usr/local/bundle \
    LANG=C.UTF-8 \
    PATH="/usr/local/bundle/bin:${PATH}"

# Install packages needed to build gems and for the asset pipeline
RUN apt-get update -qq && \
    # Install dependencies needed to manage repositories and certificates
    apt-get install --no-install-recommends -y curl gnupg ca-certificates && \
    # Create a directory for APT keys
    mkdir -p /etc/apt/keyrings && \
    # Download Yarn's GPG key and store it in the keyrings directory
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /etc/apt/keyrings/yarn.gpg && \
    # Add the Yarn repository, specifying the key for verification
    echo "deb [signed-by=/etc/apt/keyrings/yarn.gpg] https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list && \
    # Update package lists again to include the new Yarn repository
    apt-get update -qq && \
    # Now install all necessary packages, including Yarn
    apt-get install --no-install-recommends -y build-essential git libpq-dev nodejs yarn libyaml-dev pkg-config && \
    # Clean up to reduce image size
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Set the working directory to match the volume mount in docker-compose.yml
WORKDIR /coop_list

# --- Docker Caching Optimization ---
# By copying dependency files first and running install, Docker caches these layers.

# Install Ruby gems
RUN gem install rails
COPY Gemfile Gemfile.lock ./
RUN bundle install


# Copy the rest of your application's source code into the image.
# This includes package.json and yarn.lock (if they exist).
COPY . .

# Now that all files are copied, install JavaScript packages.
# This is more robust and won't fail if lock files are missing.
RUN yarn install --check-files

# Precompile assets.
# The 'ARG's from above make the database variables available to this command.
RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# Expose the port that Rails will run on
EXPOSE 3000

# The main command to run when the container starts.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]

