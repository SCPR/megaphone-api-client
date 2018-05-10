require "ostruct"
require "json"
require "rest-client"

module MegaphoneClient

  # @author Jay Arella
  class Podcast

    # @return a MegaphoneClient::Podcast instance
    # @note This is used to initialize the podcast id when creating a new Podcast instance
    # @example Create a new instance of MegaphoneClient::Podcast
    #   MegaphoneClient::Podcast.new("{podcast_id}") #=> #<MegaphoneClient::Podcast @id="{podcast_id}">

    def initialize(id=nil)
      @id = id
    end

    # @return a MegaphoneClient::Episode instance
    # @note This is used to call a new Episode instance with a given podcast id and episode_id
    # @example Call a new instance of MegaphoneClient::Episode
    #   megaphone.podcast("12345").episode("56789") #=> #<MegaphoneClient::Episode @id="{episode_Id}" @podcast_id="{podcast_id}" >

    def episode(episode_id=nil)
      MegaphoneClient::Episode.new(@id, episode_id)
    end

    # @return a MegaphoneClient::Episode instance
    # @note This is used to call a new Episode instance with a given podcast id
    # @example Call a new instance of MegaphoneClient::Episode
    #   megaphone.podcast("12345").episodes #=> #<MegaphoneClient::Episode @id=nil @podcast_id="{podcast_id}" >

    def episodes
      MegaphoneClient::Episode.new(@id)
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

    # @return a struct that represents a podcast of a given podcast id
    # @note It needs to be initialized with an @id, otherwise it will return an ArgumentError
    # @see MegaphoneClient#connection
    # @example Show a podcast
    #   megaphone.podcast("12345").show
    #   #=> A struct representing podcast 12345

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
