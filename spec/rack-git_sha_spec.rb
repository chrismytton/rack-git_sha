require 'spec_helper'

describe Rack::GitSha do
  include Rack::Test::Methods

  def app
    Rack::GitSha.new
  end

  describe "GET /" do
    before do
      get '/sha'
    end

    it "is successful" do
      last_response.status.should == 200
    end

    it "serves the current git commit sha" do
      last_response.body.should == `git rev-parse HEAD`
    end
  end
end
