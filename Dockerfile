FROM ruby:2.6.3-alpine

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
COPY package.json /usr/src/app/
COPY yarn.lock /usr/src/app/
WORKDIR /usr/src/app/

RUN set -x \
 && apk update --no-cache \
 && apk add --no-cache --virtual build-dependencies \
    build-base \
    ruby-dev \
 && apk add --no-cache \
    libxml2-dev \
    libxslt-dev \
    make \
    nodejs \
    nodejs-npm \
    yarn \
    mariadb-dev \
 && gem install nokogiri \
    -- --use-system-libraries \
    --with-xml2-config=/usr/bin/xml2-config \
    --with-xslt-config=/usr/bin/xslt-config \
 && gem install bundler -N \
 && bundle install \
 && yarn install \
 && apk del build-dependencies \
 && rm -fR /usr/lib/mysqld* \
 && rm -fR /usr/bin/mysql*

COPY . /usr/src/app/
WORKDIR /usr/src/app/

RUN npm run build \
 && rm -fR ./node_modules
