FROM ruby:3.0

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

WORKDIR /usr/src/app

COPY Gemfile fni-docs-theme.gemspec ./
RUN gem install bundler && bundle install

COPY . .

RUN bundle exec jekyll build
RUN bundle exec jekyll doctor

EXPOSE 4000
CMD bundle exec jekyll serve --host localhost
