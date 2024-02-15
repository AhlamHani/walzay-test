FROM ruby:3.0.3

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs postgresql-client curl

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle config set without 'development test'
RUN bundle install --jobs 4 --retry 3

# Copy the application
COPY . .

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Expose the port
EXPOSE 3000

# Start the application
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]