# Rack::GitSha

[![Build Status](https://secure.travis-ci.org/hecticjeff/rack-git_sha.png)](http://travis-ci.org/hecticjeff/rack-git_sha)

Tiny rack application that serves up the currently deployed git commit SHA.

Inspired by [https://github.com/site/sha](https://github.com/site/sha)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-git_sha'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-git_sha

## Usage

If your using rails 3.0+ you can mount the app in your `routes.rb` file.

```ruby
MyApp::Application.routes.draw do
  mount Rack::GitSha.new => '/sha'
end
```

If your using rack then you can map the middleware in your `config.ru`.

```ruby
require 'rack/git_sha'

map '/sha' do
  run Rack::GitSha.new
end

map '/' do
  run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['Homepage']] }
end
```

The argument that is given to `#new` is the path to the current project,
it will default to `Dir.pwd` if none is given.

After restarting your app, visiting `/sha` should give you the current
git revision.

## Tips

Once you've got your application serving the current SHA you can do some
fun stuff from the command line.

### Currently deployed SHA

    cd example-app
    curl -s http://app.example.com/sha
    git diff $(curl -fsSL http://app.example.com/sha)

This will do a diff against the deployed sha, showing you what is still
pending (much like capistrano's `cap deploy:pending:diff`).

## Known issues

* Does not work with Heroku.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
