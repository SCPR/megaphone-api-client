require "ostruct"
require "json"
require "rest-client"

module MegaphoneClient

  # @author Jay Arella
  class Episode
    def initialize(podcast_id=nil, id=nil)
      @id = id
      @podcast_id = podcast_id
    end

    # @return a MegaphoneClient
    # @note This is used as a way to access top level attributes
    # @example Accessing a network id
    #   config.network_id #=> '{network id specified in initialization}'

    def config
      @config ||= MegaphoneClient
    end

    # @return a struct that represents the episode that was created
    # @note If a @podcast_id, :body[:title], and :body[:pubdate] aren't given, it raises an error.
    # @see MegaphoneClient#connection
    # @example Create an episode
    #   megaphone.episodes.create({
    #     podcast_id: '12345',
    #     body: {
    #       title: "title",
    #       pubdate: "2020-06-01T14:54:02.690Z"
    #     }
    #   })
    #   #=> A struct representing episode '12345' with title, "title", and scheduled to publish at June 1st, 2020

    def create options={}
      if !@podcast_id || !options || !options[:title] || !options[:pubdate]
        raise ArgumentError.new("@podcast_id, options[:title], and options[:pubdate] variables are required.")
      end

      MegaphoneClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts/#{@podcast_id}/episodes",
        :method => :post,
        :body => options
      })
    end

    # @return a struct with a message that the episode was successfully/unsuccessfully deleted
    # @note If neither a @podcast_id and @episode_id are given, it raises an error
    # @see MegaphoneClient#connection
    # @example Delete an episode
    #   megaphone.episode.delete({
    #     podcast_id: '12345',
    #     episode_id: '56789'
    #   })
    #   #=> A struct with a property "success" of type "string"

    def delete options={}
      if !@podcast_id || !@id
        raise ArgumentError.new("Both @podcast_id and @id variables are required.")
      end

      MegaphoneClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts/#{@podcast_id}/episodes/#{@id}",
        :method => :delete
      })
    end

    def list options={}
      if !@podcast_id
        raise ArgumentError.new("The @podcast_id variable is required.")
      end

      MegaphoneClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts/#{@podcast_id}/episodes",
        :method => :get
      })
    end

    def show options={}
      if !@podcast_id || !@id
        raise ArgumentError.new("Both @podcast_id and @id variables are required.")
      end

      MegaphoneClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts/#{@podcast_id}/episodes/#{@id}",
        :method => :get
      })
    end

    # @return a struct (or array of structs) that represents the search results by episode
    # @see MegaphoneClient#connection
    # @example Search for an episode with externalId 'show_episode-12345'
    #   megaphone.episode.search({
    #     externalId: 'show_episode-1245'
    #   })
    #   #=> A struct representing 'show_episode-12345'

    def search params={}
      MegaphoneClient.connection({
        :url => "#{config.api_base_url}/search/episodes",
        :method => :get,
        :params => params
      })
    end

    # @return a struct that represents the episode that was updated
    # @note If neither a @podcast_id and @episode_id are given, it raises an error
    # @see MegaphoneClient#connection
    # @example Update an episode's preCount
    #   megaphone.episode.update({
    #     podcast_id: '12345',
    #     episode_id: '56789',
    #     body: { preCount: 2 }
    #   })
    #   #=> A struct representing episode '56789' with preCount 2

    def update options={}
      if !@podcast_id || !@id
        raise ArgumentError.new("Both @podcast_id and @id variables are required.")
      end

      MegaphoneClient.connection({
        :url => "#{config.api_base_url}/networks/#{config.network_id}/podcasts/#{@podcast_id}/episodes/#{@id}",
        :method => :put,
        :body => options
      })
    end
  end
end