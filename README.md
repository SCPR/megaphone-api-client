[![Build Status](https://circleci.com/gh/SCPR/megaphone_client.png)](https://circleci.com/gh/SCPR/megaphone_client)

# Megaphone Client
Unofficial Ruby client for the Megaphone API

## Installation
```bash
gem 'megaphone_client', github:"scpr/megaphone_client"
```

## Usage
**Note:** Megaphone API props, such as `externalId`, are in camelCase instead of snake_case because Megaphone's API expects it when accessing their API. So when passing params or putting/posting a hash, use camelCase. When interfacing with the gem's API, use snake_case.

### Configuration
Configure your app to connect to Megaphone, either in an initializer or your environment files:

```ruby
megaphone = MegaphoneClient.new({
  token: "{megaphone api token}",
  network_id: "{megaphone network id}",
  organization_id: "{megaphone organization id}"
})
```

### Searching

**Note:** the property `externalId` is written in camelCase because it's expected by the Megaphone API

```ruby
megaphone.episodes.search({ externalId: obj_key })
```

### Updating

**Note:** the properties in `body` are written in camelCase because it's expected by the Megaphone API

```ruby
megaphone.episodes.update({
  podcast_id: "{podcast id}",
  episode_id: "{episode id}",
  body: {
    preCount: 1,
    postCount: 2,
    insertionPoints: ["10.1", "15.23", "18"]
  }
})
```

### Listing Podcasts

```ruby
megaphone.podcasts.list
```

### Creating

```ruby
megaphone.episodes.create({
  podcast_id: '{podcast_id}',
  body: {
    title: "{episode title}",
    pubdate: "2020-06-01T14:54:02.690Z"
  }
})
```

### Deleting

```ruby
megaphone.episodes.delete({
  podcast_id: '{podcast_id}',
  episode_id: "{episode id}"
})
```

## Tests

To run the tests:
```bash
bundle exec rspec spec
```

## Documentation

You can view MegaphoneClient's documentation in RDoc format here:
http://www.rubydoc.info/github/SCPR/megaphone_client/master/

## Contributing

Pull Requests are encouraged! Suggested practice:
- Fork and make changes
- Submit a PR from fork to this master