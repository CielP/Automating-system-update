Automating system update
===
There is a product runs in Ubuntu 16.04
- It runs in a vm 
- It **does not have Internet**
- The product has two projects, they are written in python and Ruby on Rails
  - The Python project:
    - located at `/opt/project-python`
    - has a Requirements file `requirements.txt` under the path
  - The Ruby project:
    - located at `/opt/project-ruby`
    - has a Requirements files `Gemfile` under the path
    
To update the product, we want to generate a update pack, so customer can update the system **offline**.

## Things to Update
We want to update the product with a update pack that can update the product **without Internet**:
1. For Ubuntu system: perform the security updates, as same as running `unattended-upgrade` on system.
  (This is a example list of what packages unattended-upgrade would update, this command does not actually update system packages)
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
  - Update python packages required by `requirements.txt`

3. For Ruby project:
  - Update `Gemfile`
  - Update ruby gems required by `Gemfile`

## Input
Given following data:
1. A Docker image to emulate the product VM environment, `docker pull jcppkkk/automating-system-update`
  which contains the two projects. Their dependences are installed on system
  ~~~
  /opt/project-python
  /opt/project-ruby
  ~~~

2. New requirement files `requirements.txt` & `Gemfile`
  ~~~
  v2/requirements.txt
  v2/Gemfile
  ~~~

## Output
Answer this question in the level you are able to implement, higher level is better:

- Levels
  - Level 1: Manually prepare (A)
  - Level 2: Manually prepare (B)
  - Level 3: Write (C)
  - Level 4: Auto build -- (C)+(D)
  - Level 5: Auto build & test -- (C)+(D)+(E)

- Objectives
  - (A) A update pack that can update the product with Internet
  - (B) A update pack that can update the product **without Internet**
    - The size of update pack needs to be as small as possible, maximum 500MB
    - The update pack should be able to execute on the server
  - (C) A script that can fetch all latest contents to generate (B)
    - (C) always generate latest update content, even if you execute this script a few months later.
  - (D) Auto execute (C) after new commit pushed
    - Setup CI with a online CI service (gitlab-ci, Travis, circleci, Buddy...etc)
  - (E) Auto test that (B) can be applied in docker image correctly after new commit pushed
    - **Try to isolate Internat access of the docker container under test** when apply (B)

- You need to provide:
  - A git repo to track your development history
    - Write meaningful git commit messages so we can review them. https://chris.beams.io/posts/git-commit/
  - Describe your work w/wo demo(with google chrome chromcast casting) during interview
    - Use google chrome's casting
    - Internet are available
