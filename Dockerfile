FROM ruby:2.6.3

LABEL author.name="ThaiBuiXuan" \
      author.email="thaibuixuan34@gmail.com"

RUN apt-get update -qq && apt-get install -y nodejs npm\
  && rm -rf /var/lib/apt/lists/* \
  && curl -o- -L https://yarnpkg.com/install.sh | bash

WORKDIR /my_app
COPY Gemfile Gemfile.lock /my_app/
RUN bundle install
RUN npm install -g yarn
RUN yarn install --check-files
COPY server.sh /usr/bin
RUN chmod +x /usr/bin/server.sh
EXPOSE 3000
CMD [ "/usr/bin/server.sh" ]

