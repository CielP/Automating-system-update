Automating system update
===
# Description
You have a product runs in Ubuntu 16.04, which runs in a on-site vm and **does not have Internet access**. The product has two projects, they are written in python and Ruby on Rails.

## The Python project:
  - located at `/opt/project-python`
  - has a Requirements file `requirements.txt` under the path.

## The Ruby project:
- located at `/opt/project-ruby`
- has a Requirements files `Gemfile` under the path.

# Question
To update this product, we want to generate a **offline** update pack.

Given following data:
1. A Docker image to emulate the product VM environment, `docker pull jcppkkk/automating-system-update`
  which contains the two projects. Their dependences are installed on system.
  ~~~
  /opt/project-python
  /opt/project-ruby
  ~~~

2. New requirement files `requirements.txt` & `Gemfile`
  ~~~
  v2/requirements.txt
  v2/Gemfile
  ~~~

We want to update the product with a update pack that can update the product **without Internet**:
1. For Ubuntu system: perform the security updates, as same as running `unattended-upgrade` on system.
  ~~~
  root@15066d60c1f2:/# unattended-upgrade --dry-run -v
  Initial blacklisted packages: 
  Initial whitelisted packages: 
  Starting unattended upgrades script
  Allowed origins are: ['o=Ubuntu,a=xenial', 'o=Ubuntu,a=xenial-security', 'o=UbuntuESM,a=xenial']
  Option --dry-run given, *not* performing real actions
  Packages that will be upgraded: ca-certificates libasn1-8-heimdal libc-bin libdb5.3 libgcrypt20 libgnutls30 libgssapi3-heimdal libhcrypto4-heimdal libheimbase1-heimdal libheimntlm0-heimdal libhx509-5-heimdal libidn11 libkrb5-26-heimdal libldap-2.4-2 libpam-doc libpython3.5-minimal libpython3.5-stdlib libroken18-heimdal libsystemd0 libtasn1-6 libudev1 libwind0-heimdal locales multiarch-support openssh-client openssh-server openssh-sftp-server openssl python3.5 python3.5-minimal sensible-utils systemd systemd-sysv
  ~~~

2. For Python project:
  - Update `requirements.txt`
  - Update python packages required by `requirements.txt`.

3. For Ruby project:
  - Update `Gemfile`
  - Update ruby gems required by `Gemfile`.

- The update pack should be able to execute on the server.
- The update pack need no be as small as possiable, maximum 500MB.
- The structure of update pack is not limited, like:
  - Single file: update.{sh,py,rb}
  - A folder: update_files/update.{sh,py,rb}
  - Any other format that can runs

You can answer this question in different levels(choose a level to complete, higher level is better):
- Level 1: Manually prepare (A) -- A update pack that can update the product with Internet.
- Level 2: Manually prepare (B) -- A update pack that can update the product **without Internet**.
- Level 3: Write (C) -- A script(in any type) that can generate (B) with lastest updates(the update list and update packages needs to be fetched on the fly)
- Level 4: Setup auto build (D) -- auto run (C) to generate (B) after commit pushed with a online CI service(gitlab-ci, Travis, circleci, Buddy...etc).
- Level 5: Setup auto test (E) -- after (D), auto test that (B) can be applied in docker image correctly **without Internet** after commit pushed, **try to isolate Internat access of the docker container under test** when apply (B).

You need to provide:
- A git repo(archive or online repo) that can let us review your development history.
- Describe your work w/wo demo(in minutes) during interview, Internet available.

# Notes
- Keep your answer works from time to time.
- You may not have enough time to fully complete this test, but it's fine. What is important is how you do it.
