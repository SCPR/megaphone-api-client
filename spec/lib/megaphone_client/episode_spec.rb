require 'megaphone_client'
require 'ostruct'
require 'spec_helper'
require 'webmock/rspec'

describe MegaphoneClient::Episode do
  describe "create" do
    request_uri = "https://cms.megaphone.fm/api/networks/STUB_NETWORK_ID/podcasts/STUB_PODCAST_ID/episodes"

    before :each do
      @megaphone = MegaphoneClient.new({ network_id: "STUB_NETWORK_ID" })
      @episodes = @megaphone.episodes
    end

    it "should return an ArgumentError if lacking any of the required options: podcast_id, body, body[:title], body[:pubdate]" do
      expect { @megaphone.episodes.create }.to raise_error(ArgumentError)
      expect { @megaphone.episodes.create({ podcast_id: "STUB_PODCAST_ID" }) }.to raise_error(ArgumentError)
      expect { @megaphone.episodes.create({ podcast_id: "STUB_PODCAST_ID", body: {} }) }.to raise_error(ArgumentError)
      expect { @megaphone.episodes.create({ podcast_id: "STUB_PODCAST_ID", body: { title: "example_title" } }) }.to raise_error(ArgumentError)
      expect { @megaphone.episodes.create({ podcast_id: "STUB_PODCAST_ID", body: { pubdate: "2020-06-01T14:54:02.690Z" } }) }.to raise_error(ArgumentError)
    end

    it "should pass options[:body] as the body of the request" do
      VCR.use_cassette("create_result_01") do
        @megaphone.episodes.create({
          podcast_id: "STUB_PODCAST_ID",
          body: {
            title: "This is a test title",
            pubdate: "2020-06-01T14:54:02.690Z"
          }
        })

        expect(WebMock).to have_requested(:post, request_uri)
          .with(body: "{\"title\":\"This is a test title\",\"pubdate\":\"2020-06-01T14:54:02.690Z\"}")
      end
    end

    it "should only perform POST requests" do
      VCR.use_cassette("create_result_01") do
        @megaphone.episodes.create({
          podcast_id: "STUB_PODCAST_ID",
          body: {
            title: "This is a test title",
            pubdate: "2020-06-01T14:54:02.690Z"
          }
        })

        expect(WebMock).not_to have_requested(:get, request_uri)
        expect(WebMock).not_to have_requested(:put, request_uri)
        expect(WebMock).not_to have_requested(:patch, request_uri)
        expect(WebMock).not_to have_requested(:delete, request_uri)
      end
    end
  end

  describe "delete" do
    request_uri = "https://cms.megaphone.fm/api/networks/STUB_NETWORK_ID/podcasts/STUB_PODCAST_ID/episodes/STUB_EPISODE_ID"

    before :each do
      @megaphone = MegaphoneClient.new({ network_id: "STUB_NETWORK_ID" })
      @episodes = @megaphone.episodes
    end

    it "should return an ArgumentError if no podcast_id or episode_id is given" do
      expect { @megaphone.episodes.delete }.to raise_error(ArgumentError)
    end

    it "should only perform DELETE requests" do
      VCR.use_cassette("delete_result_01") do
        @megaphone.episodes.delete({
          podcast_id: "STUB_PODCAST_ID",
          episode_id: "STUB_EPISODE_ID"
        })

        expect(WebMock).to have_requested(:delete, request_uri)
        expect(WebMock).not_to have_requested(:get, request_uri)
        expect(WebMock).not_to have_requested(:patch, request_uri)
        expect(WebMock).not_to have_requested(:post, request_uri)
        expect(WebMock).not_to have_requested(:put, request_uri)
      end
    end
  end

  describe "search" do
    before :each do
      @megaphone = MegaphoneClient.new
      @episodes = @megaphone.episodes
    end

    it "should only perform GET requests" do
      request_uri = "https://cms.megaphone.fm/api/search/episodes"
      VCR.use_cassette("search_result_01") do
        @episodes.search
        expect(WebMock).to have_requested(:get, request_uri)
        expect(WebMock).not_to have_requested(:put, request_uri)
        expect(WebMock).not_to have_requested(:post, request_uri)
        expect(WebMock).not_to have_requested(:patch, request_uri)
        expect(WebMock).not_to have_requested(:delete, request_uri)
      end
    end
  end

  describe "update" do
    request_uri = "https://cms.megaphone.fm/api/networks/STUB_NETWORK_ID/podcasts/STUB_PODCAST_ID/episodes/STUB_EPISODE_ID"

    before :each do
      @megaphone = MegaphoneClient.new({ network_id: "STUB_NETWORK_ID" })
      @episodes = @megaphone.episodes
    end

    it "should return an ArgumentError if no podcast_id or episode_id is given" do
      expect { @megaphone.episodes.update }.to raise_error(ArgumentError)
    end

    it "should pass options[:body] as the body of the request" do
      VCR.use_cassette("update_result_01") do
        @megaphone.episodes.update({
          podcast_id: "STUB_PODCAST_ID",
          episode_id: "STUB_EPISODE_ID",
          body: {
            preCount: 1,
            postCount: 2,
            insertionPoints: ["10.1", "15.23", "18"]
          }
        })

        expect(WebMock).to have_requested(:put, request_uri)
          .with(body: "{\"preCount\":1,\"postCount\":2,\"insertionPoints\":[\"10.1\",\"15.23\",\"18\"]}")
      end
    end

    it "should pass an empty body if not given in options" do
      VCR.use_cassette("update_result_02") do
        @megaphone.episodes.update({
          podcast_id: "STUB_PODCAST_ID",
          episode_id: "STUB_EPISODE_ID"
        })

        expect(WebMock).to have_requested(:put, request_uri)
          .with(body: "{}")
      end
    end

    it "should only perform PUT requests" do
      VCR.use_cassette("update_result_01") do
        @megaphone.episodes.update({
          podcast_id: "STUB_PODCAST_ID",
          episode_id: "STUB_EPISODE_ID"
        })

        expect(WebMock).not_to have_requested(:get, request_uri)
        expect(WebMock).not_to have_requested(:post, request_uri)
        expect(WebMock).not_to have_requested(:patch, request_uri)
        expect(WebMock).not_to have_requested(:delete, request_uri)
      end
    end
  end
end