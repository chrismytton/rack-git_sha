require 'spec_helper'

describe Rack::GitSha do
  include Rack::Test::Methods

  def app
    Rack::GitSha.new
  end

  describe "GET /" do
    it "should respond with 200" do
      get '/'
      last_response.status.should == 200
    end
  end
end
