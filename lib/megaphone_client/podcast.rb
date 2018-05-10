require "ostruct"
require "json"
require "rest-client"

module MegaphoneClient

  # @author Jay Arella
  class Podcast
    def initialize(id=nil)
      @id = id
    end

    def episode(episode_id=nil)
      MegaphoneClient::Episode.new(@id, episode_id)
    end

    def episodes
      MegaphoneClient::Episode.new(@id).list
    end

    # @return a MegaphoneClient
    # @note This is used as a way to access top level attributes
    # @example Accessing a network id
    #   config.network_id #=> '{network id specified in initialization}'

    def config
      @config ||= MegaphoneClient
    end

    # @return an array of structs that represents a list of podcasts
    # @note It needs to be initialized with a network id
    # @see MegaphoneClient#connection
    # @example Get a list of all podcasts
    #   megaphone.podcasts.list #=> An array of structs representing a list of podcasts

    def list options={}
      MegaphoneClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts",
        :method => :get
      })
    end

    def show options={}
      if !@id
        raise ArgumentError.new("The @id variable is required.")
      end

      MegaphoneClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts/#{@id}",
        :method => :get
      })
    end
  end
end
