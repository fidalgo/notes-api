require "rails_helper"

RSpec.describe Api::V1::EntriesController, type: :routing do
  describe "routing" do

    uri_prefix = '/api/v1/notes/:note_id'
    route_prefix = 'api/v1/'

    it "routes to #index" do
      expect(:get => "#{uri_prefix}/entries").to route_to("#{route_prefix}entries#index", :note_id => ":note_id")
    end

    it "routes to #show" do
      expect(:get => "#{uri_prefix}/entries/1").to route_to("#{route_prefix}entries#show", :id => "1", :note_id => ":note_id")
    end

    it "routes to #create" do
      expect(:post => "#{uri_prefix}/entries").to route_to("#{route_prefix}entries#create", :note_id => ":note_id")
    end

    it "routes to #update via PUT" do
      expect(:put => "#{uri_prefix}/entries/1").to route_to("#{route_prefix}entries#update", :id => "1", :note_id => ":note_id")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "#{uri_prefix}/entries/1").to route_to("#{route_prefix}entries#update", :id => "1", :note_id => ":note_id")
    end

    it "routes to #destroy" do
      expect(:delete => "#{uri_prefix}/entries/1").to route_to("#{route_prefix}entries#destroy", :id => "1", :note_id => ":note_id")
    end

  end
end
