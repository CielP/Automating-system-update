Automating system update
===
There is a product that runs in Ubuntu 16.04 VM
- We have deployed multiple products VM in some various enviroment, some of them **cannot access Internet**
- The product has two projects, they are written in python and Ruby on Rails
  - The Python project:
    - located at `/opt/project-python`
    - has a Requirements file `requirements.txt` under the path
  - The Ruby project:
    - located at `/opt/project-ruby`
    - has a Requirements files `Gemfile` under the path
    
## Things to Update
We want to update all products on customer site, so we need to generate a **offline** update pack, which is based on a image of previous version of product.

1. For Ubuntu system: runs security updates offline, the result should be identical with running `unattended-upgrade` on system.
  (This is a example list of what packages unattended-upgrade would update, this command does not actually update system packages)

2. For Python project:
  - Update `requirements.txt`
  - Update python packages required by `requirements.txt`

3. For Ruby project:
  - Update `Gemfile`
  - Update ruby gems required by `Gemfile`

## Input
Given following data:
1. A Docker image (`docker pull jcppkkk/automating-system-update`) to emulate previous version of product. It contains two projects. Dependent pakcages of these two projects are installed on system.
  ~~~
  /opt/project-python
  /opt/project-ruby
  ~~~

2. New requirement files `v2/requirements.txt` & `v2/Gemfile`

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
