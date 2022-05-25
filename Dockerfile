# syntax=docker/dockerfile:1
FROM ruby:3.0.3-alpine
RUN apk add --update --no-cache \
    git \
    libpq \
    nodejs \
    tzdata \
    imagemagick \
    shared-mime-info \
    postgresql-client \
    build-base \
    libpq-dev \
    bash \
    yarn \
    sqlite-dev
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install bundler -v 2.3.4
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]%