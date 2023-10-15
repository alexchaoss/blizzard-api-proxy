FROM ruby:3.2.2

RUN mkdir /proxy
WORKDIR /proxy

COPY . /proxy/

RUN gem install bundler
RUN bundle install

EXPOSE 4567

CMD ["ruby", "blizzard_api_proxy.rb"]
