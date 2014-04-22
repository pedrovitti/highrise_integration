require 'sidekiq/testing'
require "spec_helper"

describe HighriseWorker do
  describe "perform" do
    
    let(:highrise_attr) { { "highrise_url" => "https//test.highrisehq.com", "highrise_token" => "2313204247703d92ad671aac339dc2fc" } }
    let!(:person) { Person.create!({ "name" => "TestName" }) }
    
    it "pushes job to queue" do
      Sidekiq::Testing.fake! do
        expect {
          HighriseWorker.perform_async(highrise_attr["highrise_url"], highrise_attr["highrise_token"], person.id)
        }.to change(HighriseWorker.jobs, :size).by(1)
      end
    end
  end
end