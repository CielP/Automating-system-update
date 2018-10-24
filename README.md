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
To update our server(VM) without Internat, we need to generate a **offline** update pack, which is generated based on previous version of the VM image.

1. For Ubuntu system: and archive same result as `apt update; apt upgrade` offline.

2. For Python project:
  - Update `Pipfile.lock` and archive same result as `pipenv sync` offline

3. For Ruby project:
  - Update `Gemfile` and archive same result as `bundle install` offline

## Input
Given following data:
1. A Docker image (`docker pull jcppkkk/automating-system-update`) to emulate previous version of product. It contains two projects. Dependent pakcages of these two projects are installed on system.
  ~~~
  /opt/project-python
  /opt/project-ruby
  ~~~

2. New requirement files `v2/requirements.txt` & `v2/Gemfile`

## Output
- Answer Levels
  - 1.1. A update pack that can update the product with Internet
  - 1.2. A update pack that can update the product **without Internet**
    - The size of update pack needs to be as small as possible, maximum 500MB
    - The update pack should be able to execute on the server
  - 2. A script that can fetch all latest contents to generate offline update pack
    - always generate latest update content, even if you execute this script a few months later.
  - 3.1 Auto generate offline update pack for each new commit
    - Setup CI with a online CI service (gitlab-ci, Travis, circleci, Buddy...etc)
  - 3.2 Auto test the offline update pack for each new commit
    - Ensure the update can be applied offline correctly (**Deny dns,http,https access when apply update** )
  - 3.3 Auto update image with offline update and push new image
  
Answer those levels in order, archive higher level is better. You need to provide:
- A git repo to track your development history from 1.1 to 3.3
  - Write git commit messages using commit template https://gist.github.com/zakkak/7e06725ebd1336bfebebe254de3de825
