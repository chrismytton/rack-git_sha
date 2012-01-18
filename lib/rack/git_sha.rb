require 'rack/git_sha/version'
require 'pathname'

module Rack
  class GitSha
    def initialize(root = Dir.pwd)
      @root = Pathname.new(root)
    end

    def call(env)
      if revision_file.exist?
        [200, headers, [revision_file.read]]
      else
        [200, headers, [`git rev-parse HEAD`]]
      end
    end

  private

    def revision_file
      @root.join('REVISION')
    end

    def headers
      {'Content-Type' => 'text/plain'}
    end
  end
end
