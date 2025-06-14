# Use correct Ruby version
FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  postgresql-client \
  yarn

# Install the correct Bundler version to match Gemfile.lock
RUN gem install bundler:2.3.6

# Set working directory
WORKDIR /app

# Copy Gemfile and Gemfile.lock before installing gems
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Precompile assets (optional: only if using Rails asset pipeline)
# RUN bundle exec rake assets:precompile

# Expose port (change if your app uses another port)
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]

