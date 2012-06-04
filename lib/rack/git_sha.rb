require 'rack/git_sha/version'
require 'pathname'

module Rack
  class GitSha

    def self.call(env)
      new.call(env)
    end

    # Public: Initialize a new GitSha app.
    #
    # root - The String path to application root.
    #
    # Returns the instance of GitSha.
    def initialize(root = Dir.pwd)
      @root = Pathname.new(root)
    end

    # Public: Rack interface, run when the application is requested.
    #
    # env - The Hash environment of the incoming request.
    #
    # Returns an Array `[status, headers, [body]]` for Rack.
    def call(env)
      if revision_file.exist?
        ok revision_file.read
      elsif git_repository?
        ok git_current_commit_sha
      else
        not_found 'Could not determine SHA'
      end
    end

  private

    # Get a reference to the `REVISION` file in the root of the app, this is
    # for Capistrano compatibility.
    #
    # Returns the Pathname to a possible REVISION file.
    def revision_file
      @root.join('REVISION')
    end

    # Check if the application root is a git repository.
    #
    # Returns a Boolean.
    def git_repository?
      @root.join('.git').directory?
    end

    # Get the current git commit SHA.
    #
    # Returns the String of the SHA.
    def git_current_commit_sha
      `git rev-parse HEAD`
    end

    # Easy way to get a rack 200 OK response.
    #
    # response - The String to return as the body.
    #
    # Returns a Rack compatible response array.
    def ok(response)
      [200, headers, [response]]
    end

    # Easy way to get a rack 404 response.
    #
    # response - The String to return as the body.
    #
    # Returns a Rack compatible response array.
    def not_found(response)
      [404, headers, [response]]
    end

    # Get the headers for the response.
    #
    # Returns a Hash of the response headers.
    def headers
      {'Content-Type' => 'text/plain'}
    end
  end
end
