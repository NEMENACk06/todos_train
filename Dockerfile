# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.4.2
FROM docker.io/library/ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# Base packages
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libjemalloc2 libvips postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development"

# ---------------- Build stage ----------------
FROM base AS build

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libyaml-dev pkg-config && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# App code
COPY . .

# Precompile bootsnap code
RUN bundle exec bootsnap precompile app/ lib/

# (สำคัญ) ไม่ precompile assets ใน build stage — เราจะทำตอน runtime
# RUN SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile

# ---------------- Final stage ----------------
FROM base

# Copy gems & app
COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /rails /rails

# Create app user & fix permissions (รวมโฟลเดอร์ tailwind build)
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
    mkdir -p /rails/log /rails/tmp /rails/storage /rails/app/assets/builds/tailwind && \
    chown -R rails:rails /rails
USER 1000:1000

# Ensure entrypoint is executable (ไฟล์นี้ต้องมีใน repo)
RUN chmod +x /rails/bin/docker-entrypoint

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

# Start server (ต้องฟัง $PORT และ 0.0.0.0 บน Render)
CMD ["bash","-lc","bundle exec rails s -b 0.0.0.0 -p ${PORT:-3000}"]
