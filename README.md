# Noted.

[![Build Status](https://secure.travis-ci.org/noted/noted.png?branch=master)](https://travis-ci.org/noted/noted) [![Dependency Status](https://gemnasium.com/noted/noted.png)](https://gemnasium.com/noted/noted) [![Code Climate](https://codeclimate.com/github/noted/noted.png)](https://codeclimate.com/github/noted/noted) [![Coverage Status](https://coveralls.io/repos/noted/noted/badge.png?branch=master)](https://coveralls.io/r/noted/noted)

Noted is an academic research assistant and social network.

**Authors** &mdash; [Ethan Turkeltaub](http://ethnt.me), [Earl Procko](http://is.gd/pIAqSy).

<hr />

## Installation

Noted requires the following dependencies to run:

* Ruby (MRI 2.0.0-p0; I suggest using rbenv/RVM)
* MongoDB (~ 2.4.1)
* Redis (~ 1.3.15)
* Memcached (~ 1.4.5)

Install Bundler system-wide, then run:

```
$ bundle install
```

To start a development server, run:

```
$ bundle exec foreman start
```

To run a production server on port 80, you'll need root privileges. If have Ruby installed system-wide, run:

```
$ RACK_ENV=production sudo bundle exec puma -C config/puma.rb
```

If you have Ruby installed with rbenv, I'd suggest using the rbenv-sudo plugin, then running:

```
$ rbenv sudo RACK_ENV=production bundle exec puma -C config/puma.rb
```
