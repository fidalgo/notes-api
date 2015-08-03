require "rails_helper"

RSpec.describe Api::V1::NotesController, type: :routing do
  describe "routing" do

    uri_prefix = '/api/v1'
    route_prefix = 'api/v1/'

    it "routes to #index" do
      expect(:get => "#{uri_prefix}/notes").to route_to("#{route_prefix}notes#index")
    end

    it "routes to #show" do
      expect(:get => "#{uri_prefix}/notes/1").to route_to("#{route_prefix}notes#show", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "#{uri_prefix}/notes").to route_to("#{route_prefix}notes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "#{uri_prefix}/notes/1").to route_to("#{route_prefix}notes#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "#{uri_prefix}/notes/1").to route_to("#{route_prefix}notes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "#{uri_prefix}/notes/1").to route_to("#{route_prefix}notes#destroy", :id => "1")
    end

  end
end
