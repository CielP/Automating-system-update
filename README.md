Automating system update
===
# Description
You have a product runs in Ubuntu 16.04, which runs in a on-site vm and does not have Internet access. The product has two projects, they are written in python and Ruby on Rails.

## The Python project:
  - located at `/opt/project-python`
  - has a Requirements file `requirements.txt` under the path.

## The Ruby project:
- located at `/opt/project-ruby`
- has a Requirements files `Gemfile` under the path.

# Question
To update this product, we want to generate a offline update pack.

Given following data:
1. A Docker image to emulate the product vm, which contains two projects
  ~~~
  /opt/project-python/requirements.txt
  /opt/project-ruby/Gemfile
  ~~~
2. New requirement files `requirements.txt` & `Gemfile`

We want to update following things with a update pack **without Internet access**:
1. For Ubuntu system: perform the security updates.
2. For Python project:
  - Update `requirements.txt`
  - Update python packages required by `requirements.txt`.
3. For Ruby project:
  - Update `Gemfile`
  - Update ruby gems required by `Gemfile`.

Please implement a method that can automatically generate the update pack.
  - The implementation can be shell/python/ruby script, any frameworks or any other way that works.
  - The generated update pack should be able to execute on the server. like:
    - Single file: update.{sh,py,rb}
    - A folder: update_files/update.{sh,py,rb}
    - Any other format that runs

You need to provide:
- Works on github or other git service that can trace your development history.
- describe your works w/wo demo(in minutes) during interview.

# Notes
- Keep in mind that you may not have enough time to finish all requirements, but it's fine, just keep your answer works (partially)
