require 'rack/git_sha/version'

module Rack
  class GitSha
    def call(env)
      [200, {'Content-Type' => 'text/plain'}, [`git rev-list HEAD`]]
    end
  end
end
