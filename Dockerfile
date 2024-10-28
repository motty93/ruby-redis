FROM ruby:2.7.8

ENV APP_ROOT="/myapp" \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo

RUN apt-get update -qq && \
    apt-get install -y build-essential

WORKDIR /tmp

COPY Gemfile Gemfile.lock ./

RUN bundle install --path vendor/bundle && \
    bundle clean --force && \
    rm -rf /var/lib/apt/lists/*

WORKDIR $APP_ROOT
COPY . ${APP_ROOT}/

CMD ["bundle", "exec", "ruby", "main.rb"]
