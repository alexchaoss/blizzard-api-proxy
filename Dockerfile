FROM ruby:3.0.0

RUN mkdir /proxy
WORKDIR /proxy

ADD Gemfile /proxy/Gemfile
ADD Gemfile.lock /proxy/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD . /proxy/

EXPOSE 4567

CMD ["ruby", "blizzard_api_proxy.rb"]
