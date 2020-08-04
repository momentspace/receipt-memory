FROM ruby:2.6.6
ENV RAILS_ENV="production"
RUN apt-get update -qq && apt-get install -y postgresql-client
RUN mkdir -p /app
WORKDIR /app
COPY Gemfile Gemfile.lock /app/
RUN bundle --path vendor/bundle
COPY . /app

RUN SECRET_KEY_BASE=placeholder bundle exec rails assets:precompile \
 && rm -rf tmp/cache

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
