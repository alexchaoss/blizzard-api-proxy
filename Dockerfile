FROM ruby:2.6.5

RUN mkdir /proxy
WORKDIR /proxy

ADD Gemfile /proxy/Gemfile
ADD Gemfile.lock /proxy/Gemfile.lock

RUN gem install bundler
RUN bundle install

ADD ./blizzard_api_proxy.rb /proxy/blizzard_api_proxy.rb

EXPOSE 4567

CMD ["ruby", "blizzard_api_proxy.rb"]
