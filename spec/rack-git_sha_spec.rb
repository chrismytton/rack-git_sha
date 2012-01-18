require 'spec_helper'

describe Rack::GitSha do
  include Rack::Test::Methods

  describe "GET /" do
    context "with no path" do
      def app
        Rack::GitSha.new
      end

      before do
        get '/'
      end

      it "is successful" do
        last_response.status.should == 200
      end

      it "serves the current git commit sha" do
        last_response.body.should == `git rev-parse HEAD`
      end

      context "with path" do
        def app
          Rack::GitSha.new File.expand_path('../fixtures', __FILE__)
        end

        before do
          get '/'
        end

        it "uses the REVISION file" do
          last_response.body.should == "git-sha-goes-here\n"
        end
      end
    end
  end
end
