require 'rack/git_sha/version'
require 'pathname'

module Rack
  class GitSha
    def initialize(root = Dir.pwd)
      @root = Pathname.new(root)
    end

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

    def revision_file
      @root.join('REVISION')
    end

    def git_repository?
      @root.join('.git').directory?
    end

    def git_current_commit_sha
      `git rev-parse HEAD`
    end

    def ok(response)
      [200, headers, [response]]
    end

    def not_found(response)
      [404, headers, [response]]
    end

    def headers
      {'Content-Type' => 'text/plain'}
    end
  end
end
