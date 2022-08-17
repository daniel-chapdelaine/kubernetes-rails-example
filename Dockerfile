# this fetches a prebuilt docker image for us to customize
FROM ruby:2.5
ARG RAILS_MASTER_KEY
# everthing we do below will customize the prebuilt image
ENV RAILS_MASTER_KEY=${RAILS_MASTER_KEY}
ENV RAILS_ENV=production
RUN gem update --system 3.2.3
# run the following so that we have updated versions of node and yarn 
RUN curl https://deb.nodesource.com/setup_16.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
# now run apt-get and install libraries
RUN apt-get update && apt-get install -y nodejs yarn postgresql-client

# here we copy our rails app
RUN mkdir /app
# make it the working directory so commands run smoothly
WORKDIR /app
# copy our gemfile so that docker can cache the build image if there are no changes
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY . .

# precompile assets like stylesheets and scripts
RUN rake assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]