FROM ruby:3.2

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs

WORKDIR /site

# Copy Gemfile and Gemfile.lock first, install gems, then copy the rest (for Docker cache efficiency)
COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . .

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0"]