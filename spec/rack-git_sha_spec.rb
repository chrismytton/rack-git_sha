require 'spec_helper'

describe Rack::GitSha do
  include Rack::Test::Methods

  describe "GET /" do
    context "with no path" do
      let(:app) { Rack::GitSha }

      before { get '/' }

      it "is successful" do
        last_response.status.should == 200
      end

      it "serves the current git commit sha" do
        last_response.body.should == `git rev-parse HEAD`
      end

      context "with path" do
        let(:app) { Rack::GitSha.new File.expand_path('../fixtures', __FILE__) }

        before { get '/' }

        it "uses the REVISION file" do
          last_response.body.should == "git-sha-goes-here\n"
        end
      end

      context "with path that isn't git root or have REVISION file" do
        let(:app) { Rack::GitSha.new File.dirname(__FILE__) }

        before { get '/' }

        it "returns a 404" do
          last_response.status.should == 404
        end
      end
    end
  end
end
