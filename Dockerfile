FROM ruby:latest

WORKDIR /app

COPY Gemfile Gemfile.lock* ./

RUN bundle install

COPY . .

CMD ["ruby", "main.rb"]

