# Rack::GitSha

Tiny rack application that serves up the currently deployed git commit SHA.

## Installation

Add this line to your application's Gemfile:

    gem 'rack-git_sha'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rack-git_sha

## Usage

If your using rails 3.0+ you can mount the app in your `routes.rb` file.

```ruby
MyApp::Application.routes.draw do
  mount Rack::GitSha.new(Rails.root) => '/sha'
end
```

After restarting your app, visiting `/sha` should give you the current
git revision.

If your using rack then you can map the middleware in your `config.ru`.

```ruby
map '/sha' do
  run Rack::GitSha.new(File.dirname(__FILE__))
end

map '/' do
  run Sinatra::Application # Or whatever.
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
