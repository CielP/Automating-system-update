FROM phusion/baseimage:0.10.2

RUN sed -i -e 's/archive.ubuntu.com/free.nchc.org.tw/' /etc/apt/sources.list
ADD internal/apt.sh /usr/bin/


# Python
RUN install_clean python
RUN curl --silent --show-error --fail --retry 5 https://raw.githubusercontent.com/kennethreitz/pipenv/master/get-pipenv.py | python
RUN install_clean libjpeg8-dev gcc python-dev libssl-dev swig 
ADD v1/Pipfile v1/Pipfile.lock /opt/foobar/
RUN cd /opt/foobar; PIPENV_VENV_IN_PROJECT=1 pipenv sync

# Ruby
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN install_clean git-core curl zlib1g-dev build-essential libssl-dev \
  libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev \
  libcurl4-openssl-dev python-software-properties libffi-dev nodejs yarn

ENV PATH /root/.rbenv/bin:/root/.rbenv/shims:$PATH
RUN curl -fsSL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc


# Deploy Gemfile
ADD v1/Gemfile v1/Gemfile.lock v1/.ruby-version /opt/foobar/
WORKDIR /opt/foobar/
RUN rbenv install -s && gem install bundler
RUN install_clean libpq-dev
RUN bundle install --deployment
WORKDIR /
