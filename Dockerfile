# Stage 1: Build
FROM ruby:3.0.3-alpine as Builder

# Install build dependencies
RUN apk add --update --no-cache \
      build-base \
      nodejs \
      yarn \
      tzdata \
      postgresql-dev \
      git

WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle config set without 'development test'
RUN bundle install --jobs 4 --retry 3

# Copy the application
COPY . .

# Stage 2: Runtime
FROM ruby:3.0.3-alpine

# Install runtime dependencies
RUN apk add --update --no-cache \
      postgresql-client \
      tzdata

WORKDIR /app

# Copy from builder
COPY --from=Builder /app /app

# Expose the port
EXPOSE 3000

# Start the application
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]